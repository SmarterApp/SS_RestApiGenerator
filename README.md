sb11-rest-api-generator
=======================

REST API Generator Information

Quick setup guide
=================================================
If:
   
1. you are using spring mvc to produce REST webservices.
1. testing it using spring-test's mock http requests, and
1. Building your rest application using sb11 shared build,
   
You can:
   
1. include the dependencies in your rest pom file (step 1 below) and
1. add the interceptor to your test context.
    
Under the hood of the API generator 
=================================================

Sections:

1. Maven Dependencies
1. Test Strategy
1. Test MVC Interceptor
1. Build Settings
1. Web fragment
1. API URL


#  Maven Dependencies 

Include the following dependencies to your project with the appropriate version number:

        <dependency>
            <groupId>org.opentestsystem.shared</groupId>
            <artifactId>rest-api-generator</artifactId>
            <version>0.0.1-SNAPSHOT</version>
            <type>jar</type>
        </dependency>

        <dependency>
            <groupId>org.opentestsystem.shared</groupId>
            <artifactId>rest-api-generator</artifactId>
            <version>0.0.1-SNAPSHOT</version>
            <type>test-jar</type>
            <scope>test</scope>
        </dependency>
        

#  Test strategy

* This project assumes you are testing your REST web services by using a mock http request.
* The API generator uses a request interceptor to save request and response data to use as examples of how to interact with the RESTful API.
* The example data is serialized (json format) to a file named api_examples.json which the running application will later use to display the examples on a web page.

Our projects are using spring-mvc to create rest web services and spring-test to setup the testing framework.
Those are well documented online.

Additionally, there is an annotation in the api-generator project that allows for marking certain tests as ignored, as well as providing the ability to order the api endpoints.

By default, if no annotations are used, all test invocations will be collected by URL and written in the order of execution.

To use the annotation, simply add a @ApiDocExample (`org.opentestsystem.shared.docs.annotation.ApiDocExample`) annotation to the jUnit method. The annotation attribute 'rank' has the following behavior:
* if you add @ApiDocExample(rank=-1), any endpoint invoked in that unit test will be _excluded_ in the api documentation 
* if you add @ApiDocExample(rank=1), any endpoint invoked in that unit test will appear first in the api documentation (note: equally-ranked API calls will be listed based on the order of execution). *NOTE: the rank can be any positive integer*
* if you do not use a rank attribute, the default is 99, and the api examples will appear in order of execution along with any other unannotated unit tests for that given URL


# Test MVC Interceptor

To configure the MVC interceptor add the following to your spring test context:
    
     <mvc:interceptors>
        <bean class="org.opentestsystem.shared.docs.RequestLoggingInterceptor" />
     </mvc:interceptors>
    
    
# Build settings
Note: If you are using the sb11 shared build, the following is already included as a build step. 

The output produced from the running the tests need to be included in your war so we can view the examples in the deployed rest application.
To accomplish this we need to add a step to our maven build.


        <plugin>
                <artifactId>maven-resources-plugin</artifactId>
                <version>2.6</version>
                <executions>
                    <execution>
                        <id>copy-resources</id>
                        <!-- here the phase you need -->
                        <phase>test</phase>
                        <goals>
                            <goal>copy-resources</goal>
                        </goals>
                        <configuration>
                            <outputDirectory>${project.build.outputDirectory}</outputDirectory>
                            <resources>
                                <resource>
                                    <directory>${project.build.directory}/test-classes</directory>
                                    <includes>
                                        <include>api_examples.json</include>
                                    </includes>
                                    <filtering>true</filtering>
                                </resource>
                            </resources>
                        </configuration>
                    </execution>
                </executions>
        </plugin>

        
# Configuration to serve the API Controller
The rest-api-generator includes a Spring MVC annotated controller and a couple JSP that will provide the API user interface for you.  
To utilize the controller and UI, you have to add an import to a spring context file which does an annotation scan at startup.  That process will wire up a spring mvc controller that will parse the json file and display the examples on a jsp file.

The api-generator context import looks like this:

       <import resource="classpath:api-gen-context.xml" />

Note: if you are getting a 404 when browsing to the api page, check how the spring context(s) are setup in your web.xml. 


# API URLs
You will be able to view your generated documentation describing your api if you browse to http://your-server/your-context/api