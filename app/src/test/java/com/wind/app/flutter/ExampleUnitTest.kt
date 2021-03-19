package com.wind.app.flutter

import org.junit.Test

import org.junit.Assert.*

/**
 * Example local unit test, which will execute on the development machine (host).
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
class ExampleUnitTest {
    @Test
    fun addition_isCorrect() {
        assertEquals(4, 2 + 2)
    }
    @Test
    fun testGenerator() {

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
}