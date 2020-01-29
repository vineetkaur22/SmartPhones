const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);



// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions




 exports.getParties = functions.https.onRequest((request, response)=> {
    const uid = request.query.uid;
    console.log("UID =" + uid);
    if(!uid){
        response.status(403).send('uid missing');
    }
    var ref = admin.database().ref("/parties/" + uid);

    switch (request.method) {
        case 'GET':
            var parties = [];
            ref.once('value',function(snapshot){ 
                parties.push(snapshot.val());
                response.status(200).send(parties);
            }).catch(error => {
                response.status(500).send(error);
            });
        
            break;
        case 'POST':
            ({title, theme, date, decorationlist} = request.body);
            ref.push({title:title, theme: theme, date:date, decorationlist:decorationlist});
            response.status(200).send('POST success!');
            break;
        case 'DELETE':
            ({partyId} = request.body);
            var deleteRef = admin.database().ref("/parties/" + uid + "/" + partyId);
            deleteRef.remove()
            .then(function() {
                console.log("Remove succeeded.")
                return response.status(200).send('DELETE success!');
            })
            .catch(function(error) {
                console.log("Remove failed: " + error.message)
                return response.status(500).send({error: 'Something blew up!'});
            });
            break;
        case 'PUT':
            response.status(200).send('PUT called!');
            break;
        default:
            response.status(405).send({error: 'Something blew up!'});
            break;
     }
});


