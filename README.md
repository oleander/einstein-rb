# Einstein

Push notification service for restaurant [Einstein](http://www.butlercatering.se/einstein.html).

Follow me on [Twitter](http://twitter.com/linusoleander) or [Github](https://github.com/oleander/) for more info and updates.

## How to use

### Today's menu

```` ruby
Einstein.menu_for(:today)
````

### Menu for any day

```` ruby
Einstein.menu_for(:monday)
````

### Push to phone

*Einstein* has build in support for [Prowl](https://www.prowlapp.com/).  
Pass you [api key](https://www.prowlapp.com/api_settings.php) to the `menu_for` method to push the menu to you iPhone. 

```` ruby
Einstein.menu_for(:monday).push_to("6576aa9fa3fc3e18aca8da9914a166b3")
````

## What is being returned?

`#menu_for` returns an array  of strings containing each dish for the given day.

## What is being push to the phone?

![Example push](http://i.imgur.com/lf8Js.png)


## Real world example

Here is a real world example using [whenever](https://github.com/javan/whenever).  
This example will push *today's menu* directly to your iPhone at 11:45 AM.

1 . Install whenever. `gem install whenever`.  
2 . Navigate to your application, run `wheneverize .`.  
3 . Add these lines to your `config/schedule.rb` file.  

```` ruby
require "rubygems"
require "einstein"

every 1.day, :at => "11:45 am" do 
  runner 'Einstein.menu_for(:today).push_to("6576aa9fa3fc3e18aca8da9914a166b3")'
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