package com.innovationcodes.telr_flutter

import com.telr.mobile.sdk.activity.WebviewActivity

import com.telr.mobile.sdk.entity.response.status.StatusResponse
import io.flutter.plugin.common.MethodChannel
import org.springframework.http.ResponseEntity

class RequestView : WebviewActivity() {
    companion object {
        lateinit var result: MethodChannel.Result
    }

    override fun onStatusSucceed(response: ResponseEntity<*>?) {
        result.success(true)
        finish()
    }

    override fun onStatusFailed(response: ResponseEntity<*>?) {
        val res = response?.body as StatusResponse
        println(res.trace)
        result.success(false)
        finish()
    }


}