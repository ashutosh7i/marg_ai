const { Vonage } = require('@vonage/server-sdk')

const vonage = new Vonage({
  apiKey: "dc32a1c8",
  apiSecret: "xXGM7eZLqFDNqB07"
})

const from = "Vonage APIs"
const to = "919098788770"
const text = 'A text message sent using the Vonage SMS API'

async function sendSMS() {
    await vonage.sms.send({to, from, text})
        .then(resp => { console.log('Message sent successfully'); console.log(resp); })
        .catch(err => { console.log('There was an error sending the messages.'); console.error(err); });
}

sendSMS();
