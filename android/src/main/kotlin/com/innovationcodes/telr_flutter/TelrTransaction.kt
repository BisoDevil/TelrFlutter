package com.innovationcodes.telr_flutter


import android.content.Context
import android.content.Intent

import com.telr.mobile.sdk.activity.WebviewActivity
import com.telr.mobile.sdk.entity.request.payment.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.math.BigInteger
import java.util.*

class TelrTransaction(
        private val context: Context,
        private val call: MethodCall,
        private val result: MethodChannel.Result) {
    init {
        startTransaction()
    }

    @Suppress("unchecked_cast")
    private fun startTransaction() {
        val args = call.arguments as Map<String, Any>
        val config = args["config"] as Map<String, Any>
        RequestView.result = result
        val intent = Intent(context, RequestView::class.java)

        intent.addFlags(Intent.FLAG_ACTIVITY_BROUGHT_TO_FRONT)
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        intent.putExtra(WebviewActivity.EXTRA_MESSAGE, getMobileRequest(call))
        intent.putExtra(WebviewActivity.SUCCESS_ACTIVTY_CLASS_NAME, "SuccessActivity")
        intent.putExtra(WebviewActivity.FAILED_ACTIVTY_CLASS_NAME, "SuccessActivity")
        intent.putExtra(WebviewActivity.IS_SECURITY_ENABLED, config["enableSecurity"] as Boolean)
        context.startActivity(intent)


    }

    @Suppress("unchecked_cast")
    private fun getMobileRequest(call: MethodCall): MobileRequest {
        println("Basem =>${call.arguments}")

        val args = call.arguments as Map<String, Any>
        val config = args["config"] as Map<String, Any>
        val billingAddress = args["billingAddress"] as Map<String, String>
        val transaction = args["transaction"] as Map<String, String>
        val mobile = MobileRequest()
        mobile.store = config["storeId"].toString()
        mobile.key = config["key"].toString()
        // Authentication Key : The Authentication Key will be supplied by Telr as part of the Mobile API setup process after you request that this integration type is enabled for your account. This should not be stored permanently within the App.
        val app = App()
        app.id = "123456789" // Application installation ID
        app.name = "Telr" // Application name
        app.user = transaction["user"] // Application user ID : Your reference for the customer/user that is running the App. This should relate to their account within your systems.
        app.version = "0.0.1" // Application version
        app.sdk = "123"

        mobile.app = app
        val tran = Tran()
        if (config["testMode"] as Boolean) {
            tran.test = "1"
        } else {
            tran.test = "0"
        }
        // Test mode : Test mode of zero indicates a live transaction. If this is set to any other value the transaction will be treated as a test.
        tran.type = "auth" /* Transaction type
                                                            'auth'   : Seek authorisation from the card issuer for the amount specified. If authorised, the funds will be reserved but will not be debited until such time as a corresponding capture command is made. This is sometimes known as pre-authorisation.
                                                            'sale'   : Immediate purchase request. This has the same effect as would be had by performing an auth transaction followed by a capture transaction for the full amount. No additional capture stage is required.
                                                            'verify' : Confirm that the card details given are valid. No funds are reserved or taken from the card.
                                                        */
        tran.clazz = "paypage" // Transaction class only 'paypage' is allowed on mobile, which means 'use the hosted payment page to capture and process the card details'
        tran.cartid = BigInteger(128, Random()).toString() //// Transaction cart ID : An example use of the cart ID field would be your own transaction or order reference.
        tran.description = " payment" // Transaction description
        tran.language = transaction["language"]
        tran.currency = transaction["currency"] // Transaction currency : Currency must be sent as a 3 character ISO code. A list of currency codes can be found at the end of this document. For voids or refunds, this must match the currency of the original transaction.
        tran.amount = transaction["amount"] // Transaction amount : The transaction amount must be sent in major units, for example 9 dollars 50 cents must be sent as 9.50 not 950. There must be no currency symbol, and no thousands separators. Thedecimal part must be separated using a dot.
        //tran.setRef();                                // (Optinal) Previous transaction reference : The previous transaction reference is required for any continuous authority transaction. It must contain the reference that was supplied in the response for the original transaction.

        //040023303844  //030023738912
        // tran.setFirstref("030023738912");             // (Optinal) Previous user transaction detail reference : The previous transaction reference is required for any continuous authority transaction. It must contain the reference that was supplied in the response for the original transaction.
        mobile.tran = tran
        val billing = Billing()
        val address = Address()
        address.city = billingAddress["city"] // City : the minimum required details for a transaction to be processed
        address.country = billingAddress["country"]?.toUpperCase(Locale.getDefault()) // Country : Country must be sent as a 2 character ISO code. A list of country codes can be found at the end of this document. the minimum required details for a transaction to be processed
        address.region = billingAddress["region"] // Region
        address.line1 = billingAddress["line"] // Street address – line 1: the minimum required details for a transaction to be processed
        //address.setLine2("SIT G=Towe");               // (Optinal)
        //address.setLine3("SIT G=Towe");               // (Optinal)
        //address.setZip("SIT G=Towe");                 // (Optinal)
        billing.address = address
        val name = Name()
        name.first = billingAddress["firstName"] // Forename : the minimum required details for a transaction to be processed
        name.last = billingAddress["lastName"] // Surname : the minimum required details for a transaction to be processed
        name.title = "Mr" // Title
        billing.name = name
        billing.email = config["email"].toString() //stackfortytwo@gmail.com : the minimum required details for a transaction to be processed.
        billing.setPhone(billingAddress["phoneNumber"])
        mobile.billing = billing
        return mobile
    }


}