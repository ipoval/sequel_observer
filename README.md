### Sequel::Observer

"Sequel::Observer" provides an easy (ActiveRecord-like) way to create the Observers for callbacks in the models of Sequel ORM.

### Creating Observers
For example, imagine a User model where we want to send an email every time a new user is created.

Since sending emails is not directly related to our model's purpose, we could create an observer to delegate that functionality.
```
  class UserObserver < Sequel::Observer
    def after_create(model_instance_record)
      # code to send confirmation email...
    end
  end
```
The observer's methods receive the instance of the model that caused the callback to fire as a parameter.

### Installing the Gem
RubyGems is the preferred easy to install method for "Sequel::Observer".
```
$ sudo gem install sequel_observer
```

#### ?s
email: ipoval@ya.ru

twitter: @ipoval
