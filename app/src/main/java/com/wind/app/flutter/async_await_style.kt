package com.wind.app.flutter

import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.http.GET
import kotlin.coroutines.*


/**
 * created by wind on 3/11/21:3:53 PM
 */
class User{}
interface UserApi{
    @GET("user")
    fun getUser(): Call<User>
}

fun main(){
    val retorfit= Retrofit.Builder().build()
    val userApi=retorfit.create(UserApi::class.java)
    async{
        val user=await{ userApi.getUser()}
        println(user)
    }

}
interface AsyncScope
fun async(
    context: CoroutineContext=EmptyCoroutineContext,
    block:suspend AsyncScope.()->Unit){

    val completion=AsyncCoroutine(context)
    block.startCoroutine(completion,completion)
}

class AsyncCoroutine(override val context: CoroutineContext=EmptyCoroutineContext):Continuation<Unit>,AsyncScope{
    override fun resumeWith(result: Result<Unit>) {
      result.getOrThrow()
    }
}
suspend fun <T> AsyncScope.await(block:()->Call<T>){
    return suspendCoroutine {
        continuation ->
        val call=block()
        call.enqueue(object :Callback<T>{
            override fun onFailure(call: Call<T>, t: Throwable) {
                continuation.resumeWithException(t);
            }

            override fun onResponse(call: Call<T>, response: Response<T>) {

            }

        })
    }
}