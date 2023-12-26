Using RabbitMQ without using partitions

To run manual tests, perform the following steps:
1. Build and start the system landscape with the following commands:
   ./gradlew build && docker-compose build && docker-compose up -d
2. Now, we have to wait for the microservice landscape to be up and running. Try running the following command a few times:
   curl -s localhost:8080/actuator/health | jq -r .status 
3. First, create a composite product with the following commands:
   body='{"productId":1,"name":"product name C","weight":300,
   "recommendations":[
   {"recommendationId":1,"author":"author 1","rate":1,"content":"content 1"},
   {"recommendationId":2,"author":"author 2","rate":2,"content":"content 2"},
   {"recommendationId":3,"author":"author 3","rate":3,"content":"content 3"}
   ], 
   "reviews":[
   {"reviewId":1,"author":"author 1","subject":"subject 1","content":"content 1"},
   {"reviewId":2,"author":"author 2","subject":"subject 2","content":"content 2"},
   {"reviewId":3,"author":"author 3","subject":"subject 3","content":"content 3"}
   ]}'

   curl -X POST localhost:8080/product-composite -H "Content-Type:application/json" --data "$body"
4. Open the following URL in a web browser: http://localhost:15672/#/queues. Log in with
   the default username/password guest/guest. You should see the following queues:
   For each topic, we can see one queue for the auditGroup, one queue for the consumer group that’s used by the corresponding core microservice, and one dead-letter queue. We can also see that the auditGroup queues contain messages, as expected!
5. Click on the products.auditGroup queue and scroll down to the Get messages section, expand it, and click on the button named Get Message(s) to see the message in the queue:
   From the preceding screenshot, note the Payload but also the header partitionKey, which we will use in the next section where we try out RabbitMQ with partitions.
6. Next, try to get the product composite using the following code:
   curl -s localhost:8080/product-composite/1 | jq
   Finally, delete it with the following command:
   curl -X DELETE localhost:8080/product-composite/1
   Try to get the deleted product again. It should result in a 404 - "NotFound" response!
   If you look in the RabbitMQ audit queues again, you should be able to find new messages
   Next, try to get the product composite using the following code:
   curl -s localhost:8080/product-composite/1 | jq
   Finally, delete it with the following command:
   curl -X DELETE localhost:8080/product-composite/1
   Try to get the deleted product again. It should result in a 404 - "NotFound" response!
   If you look in the RabbitMQ audit queues again, you should be able to find new messages
6. Next, try to get the product composite using the following code:
   curl -s localhost:8080/product-composite/1 | jq
7. Finally, delete it with the following command:
   curl -X DELETE localhost:8080/product-composite/1
8. Try to get the deleted product again. It should result in a 404 - "NotFound" response!
9. If you look in the RabbitMQ audit queues again, you should be able to find new messages
10. Wrap up the test by bringing down the microservice landscape with the following command:
    docker-compose down
-------------------------------------------------------------------------------------------------------------------------
Using RabbitMQ with partitions
Now, let’s try out the partitioning support in Spring Cloud Stream!
Start up the microservice landscape with the following command:

export COMPOSE_FILE=docker-compose-partitions.yml
docker-compose build && docker-compose up -d

To end the test with RabbitMQ using partitions, bring down the microservice landscape with the following command:
docker-compose down
unset COMPOSE_FILE

-------------------------------------------------------------------------------------------------------------------------

Using Kafka with two partitions per topic

Start up the microservice landscape with the following command:

export COMPOSE_FILE=docker-compose-kafka.yml
docker-compose build && docker-compose up -d

To see a list of topics, run the following command:

docker-compose exec kafka kafka-topics --bootstrap-server localhost:9092 --list

To see the partitions in a specific topic, for example, the products topic, run the following command:
docker-compose exec kafka kafka-topics --bootstrap-server localhost:9092 --describe --topic products

To see all the messages in a specific partition, for example, partition 1 in the products topic, run the
following command:
docker-compose exec kafka kafka-console-consumer --bootstrap-server localhost:9092 --topic products --from-beginning --timeout-ms 1000 --partition 1

Bring down the microservice landscape with the following command:
docker-compose down
unset COMPOSE_FILE