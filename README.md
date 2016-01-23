# Networking Helper

Small wrapper for basic networking calls with NSURLSession. It also makes use of an [Auto Layout Helper](https://github.com/franciscojma86/autolayout) I recently built (check it out!).
This demo app will show a list of objects in from a Parse app I created only for this demo app. First it will query them, and if you tap on the "+" button, you can create a new one by adding a name.

The objective of this helper class is to simplify common calls to REST APIs, and just pass the information needed, without the need of creating a session or handling errors.

It comes with another helper class called NetworkingErrorMessages.h, that depending on the error type or status code, it will return a string ready for you to display.

This is project is nowhere near completed, but it's a good starting point to build on.

## Tutorial

The backend for this app was built using [Parse](www.parse.com). I created the app just for this project, so i already added the credentials needed for the demo app.
You must install the Parse cocoapods first. Here's a link for a quick tutorial on [using Parse with cocoapods](https://cocoapods.org/pods/Parse).

Once that is done, you can run the demo app and see how it works.

NOTE: You DON'T need to use pase to use the helper classes if you use in your app. This is JUST for the demo app.

If you use this helper in your app, make sure you change the base URL to your own, and change the headers in the NSURLSessionConfigurtaion creaton.

NetworkingClient class will be used as a Singleton, using "sharedClient" as the global instance. As of now, it has only two methods.

```
-(NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url
                                    body:(id)body
                        successDataBlock:(SuccessDataBlock)sucessDataBlock
                        successJSONBlock:(SuccessJSONBlock)successJSONDataBlock
                                 failure:(FailMessageBlock)failure;

```

and 

```
-(NSURLSessionDataTask *)dataTaskWithMethod:(NSString *)method
                                       path:(NSString *)path
                                       body:(id)body
                           successDataBlock:(SuccessDataBlock)sucessDataBlock
                           successJSONBlock:(SuccessJSONBlock)successJSONDataBlock
                                    failure:(FailMessageBlock)failure;

```

The only difference between these two methods is the first two values they take. In dataTaskWithURL: you must pass a URL directy, no HTTP method.
This is specially useful for downlading images when you have the full URL already.

The method dataTaskWithMethod: will take in an HTTP method (GET, POST, PUT, etc), and a relative path i.e. "/classes/testobjects". It will be added to your base URL.

Both methods take 3 blocks that work very similarly. None of them pass any arguments, but return different values.
- **SuccessDataBlock**: will return an NSData object, passed directly from the NSURLSessionDataTask call.
- **SuccessJSONBlock**: will return either an NSArray or an NSDictionary, parsed from the data returned from the NSURLSessionDataTask call.
- **FailMessageBlock**: will return a string with a pre-built message depending on the errors obtained from the NSURLSessionDataTask call. It also returns a "cancelled" BOOL value to indicate if the call failed because the user cancelled the call. In this case you might want your callback to behave differently.


That's pretty much it for now. Still lot's of work to do, like addding deletion and objects updating, so I'll be adding that soon. 
