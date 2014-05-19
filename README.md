Flower Shop Code
================

This gem is executable.

Run this command to learn more

```
bundle exec rake -T
```

Dependencies
------------

This gem is built using Ruby 2.0.0.
Run this command to install dependencies. You need to have Bundler installed.
```
bundle install
```

E2E Testing
-----------
You can run this rake task to execute the rspec that tests the complete solution.
```
bundle exec rake e2e
```


Building
--------

The ci task runs the automated tests, builds the gem and installs the gem locally
```
bundle exec rake ci
```

Running the Flower Shop Invoicer
---------------------------

After you have built and installed the gem you can run flower_shop_invoicer

### Help
Run this command to get help
```
flower_shop_invoicer -h
```

### Example:
```
flower_shop_invoicer spec/fixtures/order.txt
```

