Microservices scope product functionality into units that can be individually deployed. 

https://docs.microsoft.com/en-us/azure/architecture/includes/images/microservices-logical.png

For example, in traditional pre-cloud-native deployments, it was common to have a single website service that managed APIs and customer interactions. With microservices, you would decompose this website into multiple services, such as a checkout service and a user service. Then, you could develop, deploy, and scale these services individually.

Additionally, microservices are often stateless, and leveraging twelve-factor applications allows companies to take advantage of the flexibility that cloud native tooling offers.

Recommended Technology: 
    Node.js - https://nodejs.org/
Alternative Technology: 
    Kotlin - https://kotlinlang.org/
    Golang - https://golang.org/

References 
Twelve-Factor Applications - https://12factor.net/