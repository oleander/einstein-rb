# Einstein

Push notification service for restaurant [Einstein](http://www.butlercatering.se/einstein.html).

Follow me on [Twitter](http://twitter.com/linusoleander) or [Github](https://github.com/oleander/) for more info and updates.

## How to use

### Today's menu

```` ruby
Einstein::Menu.new(:today).dishes
````

### Menu for any day

```` ruby
Einstein::Menu.new(:monday).dishes
````

### Push to phone

*Einstein* has build in support for [Prowl](https://www.prowlapp.com/).  
Just pass you [api key](https://www.prowlapp.com/api_settings.php) to `#push_to` and the menu will be push to you phone within seconds.

```` ruby
Einstein::Menu.new(:monday).push_to("6576aa9fa3fc3e18aca8da9914a166b3")
````

## What's being returned?

`#dishes` returns an array of strings containing each dish for the given day.

## What is being push to the phone?

![Example push](http://i.imgur.com/lf8Js.png)

## Real world example

Here is a real world example using [whenever](https://github.com/javan/whenever).  
It will push *today's menu* directly to your iPhone each day at 11:45 AM.

1 . Install whenever. `gem install whenever`.  
2 . Navigate to your application, run `wheneverize .`.  
3 . Add these lines to your `config/schedule.rb` file.  

```` ruby
require "rubygems"
require "einstein"

every 1.day, at: "11:45 am" do 
  runner 'Einstein::Menu.new(:today).push_to("6576aa9fa3fc3e18aca8da9914a166b3")'
end
````

4 . Create the cron task using `whenever`.  
5 . Done!  

## How to install

    [sudo] gem install einstein

## Requirements

*Einstein* is tested in *OS X 10.6.7* using Ruby *1.9.2*.

## License

*Einstein* is released under the *MIT license*.