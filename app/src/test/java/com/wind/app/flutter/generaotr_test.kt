package com.wind.app.flutter

import java.lang.IllegalStateException
import java.lang.IndexOutOfBoundsException
import kotlin.coroutines.*

/**
 * created by wind on 3/11/21:2:28 PM
 */


fun testGenerator() {
    /**
     * 分析：
     * 1、generator 接收一个函数类型的参数 ，计为 FuncA
     * 2、genetator函数的返回值依然就个函数，计为 FuncB
     * 3、FuncB 的返回值是一个 Iterable
     */

    val nums = genetator { start:Int->
        for (i in 0..5){
            yield(start+i)
        }

    }


    val gen=nums(10)
    for (i in gen){
        println(i)
    }
}

interface Generator<T> {
    operator fun iterator(): Iterator<T>


}

interface GeneratorScope<T>{
    suspend fun yield(value:T)
}

class GeneratorIterator<T>(
    private val block: suspend GeneratorScope<T>.(T) -> Unit,
    private val parameter: T, override val context: CoroutineContext = EmptyCoroutineContext
) : GeneratorScope<T>, Iterator<T>, Continuation<Any?> {

    private var state: State

    init {

        val coroutineBlock: suspend GeneratorScope<T>.() -> Unit = { block(parameter) }

        val start = coroutineBlock.createCoroutine(this, this)
        state = State.NotReady(start)
    }

    override fun hasNext(): Boolean {
        resume()
        return state != State.Done
    }

    override fun next(): T {
        return when (val currentState = state) {
            is State.NotReady -> {
                resume()
                return next()
            }

            is State.Ready<*> -> {
                state = State.NotReady(currentState.continuation)
                (currentState as State.Ready<T>).nextValue
            }
            State.Done -> throw IndexOutOfBoundsException("No value left.")

        }
    }

    private fun resume() {
        when (val currentState = state) {
            is State.NotReady -> currentState.continuation.resume(Unit)
        }
    }

    override fun resumeWith(result: Result<Any?>) {
        state = State.Done
        result.getOrThrow()
    }

    override suspend fun yield(value: T) {
        return suspendCoroutine<Unit> {
                continuation ->
            state=when(state){
                is State.NotReady -> State.Ready(continuation,value)
                is State.Ready<*> ->
                    throw IllegalStateException("Can't yield when ready.")
                State.Done -> throw IllegalStateException("Can't yield when done")
            }
        }
    }


}

sealed class State {
    class NotReady(val continuation: Continuation<Unit>) : State()
    class Ready<T>(val continuation: Continuation<Unit>, val nextValue: T) : State()
    object Done : State()

}

class GeneratorImpl<T>(val block: (suspend GeneratorScope<T>.(T) -> Unit), val parameter: T) :
    Generator<T> {
    override fun iterator(): Iterator<T> {
        return GeneratorIterator<T>(block, parameter)
    }


}

fun <T> genetator(block: (suspend GeneratorScope<T>.(T) -> Unit)): (T) -> Generator<T> {

    return { parameter: T ->
        GeneratorImpl(block, parameter)
    }

}