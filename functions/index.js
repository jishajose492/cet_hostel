const functions= require("firebase-functions");
const stripe=require('stripe')(functions.config().stripe.testkey)
const calculateOrderAmount=1000;
const generateResponse=function(intent){
    switch(intent.status){
        case'requires_action':
        return{
            clientSecret:intent.clientSecret,
            requiresAction:true,
            status:intent.status,
        };
        case 'requires_payment_method':
            return{
                'error':'Your card was denied,please provide a new  payment method'
            };
            case 'succeeded':
                console.log('Payment succeeded.');
                return{
                    clientSecret:intent.clientSecret,status:intent.status,
                };    }
                return{error:'Failed'};
}
exports.StripePayEndpointMethodId=functions.https.onRequest(async(req,res)=>{
    const{paymentMethodId,items,currency,useStripeSdk,}=req.body;
    const orderAmount=calculateOrderAmount(items);
    try {
        if(paymentMethodId){
            const params={
                amount:orderAmount,
                confirm:true,
                confirmation_method:'manual',
                currency:currency,
                payment_method:paymentMethodId,
                use_stripe_sdk:useStripeSdk
            }
            const intent=await stripe.paymentIntents.create(params);
            console.log('Intent:${intent}');
            return res.send(generateResponse(intent));
        }
        return res.sendStatus(400)
        
    } catch (e) {
        return res.send({error:e.message});
    }
});
exports.StripePayEndpointIntentId=functions.https.onRequest(async(req,res)=>{
    const {paymentIntentId}=req.body;
    try {
        if(paymentIntentId){
            const intent=await stripe.paymentIntents.confirm(paymentIntentId);
            return res.send(generateResponse(intent));
        }
        
    } catch (e) {
        
    }
});

/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
