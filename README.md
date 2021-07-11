# Cinema Manager

Hi there. Welcome to Cinema Manager interview project. I have to say that I got a bit carried away with functionality. It took me slightly more time than I expected. There is possibility that Authentication feature was a bit of overkill, but I had a lot of fun with it. :) I implemented everything that was required except for reviews endpoint. If I had more time I would finish it and probably played with exceptions and response code and messages, because there room for improvement in case of adjusting status codes, creating more detailed messages and stuff like this. Also checked code for some unobvious edge cases. 

## Setup

1) `gem install rails`
2) `bundle install`
3) `rake db:setup`
4) Prepare your `.env` file with based on `.env.example` file 
3) `rails s` to run the server. Enjoy :)

## Specs running

`rspec spec`

## Decision making
### Database Structure

I had couple ideas about creating data structure. Simplest idea would be to have owner object that is associatiated with movies and this movies have timeshows. This is ok for one owner object. But in realistic scenario there wouldn't be probably one owner. Apps almost always has multiple users (for example if there would be multiple cinemas with multiple owners) so in above structure there would be huge data duplication and memory loss. For each two users having the same movie there would be two movie objects with same title and imdb_id. 

Other idea was to have some many-to-many relation between movie and user and to this attach timestamps. This would be most efficient from database memory stand point, but I felt that it gets a little bit overcomplicated and demanded too much time to implement small project like that. It would be probably prefered in huge project where we would end up with millions of users, movies and timeshows.

Final idea that I went for was a little bit between of two above. I dropped additional many-to-many relation and used timeshows as many-to-many relation. There is still tiny memory leak in here, because timeshow in this case have two foreign keys instead of one and if this would be real project that would be probably biggest table in database, but it was much faster to use and implement.

### Authorization and Authentication

When I saw that one endpoint is supposed to be just for owner I've immediately decided to use some kind of authorization and authentication system. In my previous projects I used to use Oauth2 with Doorkeeper gem with password grant type. Unfortunetly when I was browsing through Oauth2 documentation I found that password grant type is legacy and should not be used. So I thought that it is good opportunity to write some custom Authentication and Authorization system using JWT tokens that are gaining popularity for some time.

#### Authentication
I wrote small service that checks if user sent proper username and password and sends token back. In case of any problems with authentications we rise Error and user gets information with http status code. This is still very basic functionality if I would have more time or this would be enterprise project I would also add some token expiration and uniqueness, because right now token will always be the same. Also some additional functionalities could be added like token revocation and refreshment.

#### Authorization
This functionality I've put to grape middleware, because If user is not authorized there shouldn't be need to call controller/endpoint action. In middleware we check if token decodes correctly and if this is real user. If all end with success we assign user to env which is later accessible in endpoints via `current_user` helper. I also added little useful tweak we can define which action should be authorized by running `authenticate_user`. Middleware will check authorization only if this is set. If app would be bigger and multiple users and roles be added this could be expanded to check if user not only exists but also his/her role is allowed to perform action.

### JSON Api Serialization

I went with using JSON Api standard as serialization. I think that it is very useful tool when two developers work on same functionality from both sides. When it is established that we use JSON API for example then there is less negotiation with mobile developer on how to build your API, you just follow convention.

### Grape

I used Grape because this is tool that I'm most familiar with. GraphQL would work in here nicely too.

### Secret data

For storage of secret data like Api keys I used dotenv gem and stored data in `.env` file in my project. I assigned them all in rails `application.rb` so it could be easly accessed.

### Swagger

Swagger can be accessed via `localhost:3000/swagger` 

### Persistance layer

For data persistance I used ActiveRecord and created some small services to perform actions on objects. In this small example it might seem a bit over the top, but normally in real life projects there would be some others actions performed like sending emails, updating other objects, associations, running some background jobs etc so it all would be run at the end in this service classes. They are easly expandable without creating unnecessary mess in endpoints.

### Other features

In real time project I would also use pagination for listing timeshows. In case of thousands of records size of response would be huge and there would be a lot of opportunities for problems so easiest thing to eliminate that would be to create some sort of offset or cursor pagination depending on needs.

