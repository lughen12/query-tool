# query-tool
This CLI is made to fullfill screening accessment for 90 Seconds.

### Prerequisite
1. Install ruby (tested with ruby 2.2.6)
2. Install bundle `gem install bundler`
3. Install dependancies in project directory `bundle install`

### Example Usage
1. Get all results for resource
```
ruby main.rb -r user
```

2. Query a resource
```
ruby main.rb -r user -q name="Raylan Givens",tags=Springville
```

3. Query a resource with limit (default is 5)
```
ruby main.rb -r user -l 1
```

4. Query a resource with offset (default is 0)
```
ruby main.rb -r user -o 1
```

5. Change output format (default: text)
```
ruby main.rb -r user -f json
```

6. Display helps
```
ruby main.rb -h
```

7. Run tests
```
bundle exec rspec spec/
```

### Evaluation Criteria
1. Extensibility (separation of concerns)
The project is splitted into these following directories:
- `models`: Classes to represent resources. Currently only support user and project. For supporting new resource, just create another model class.
- `presenter`: Classes to format ruby hash. Currently only support formatted text and json. For supporting new format, just create another presenter class.
- `services`: Classes to do some specific logics. Currently there are 2 services. `CommandService` to parse CLI command to options hash, and `QueryService` to execute query from the option hash.
- `specs`: All the test in the application.

2. Simplicity
- Minimal dependancies

3. Test Coverage
- 100% coverage for `models`, `presenters` and `services`

4. Performance
- Support `limit` and `offset` as CLI options. When data set become larger, user can paginate their query commands.
- The solution load the whole file to memory, and loop through the whole array (O(n) in time complexity) to perform a query. This approach will not work well if data set increases.
- Building an in-memory tree before searching has been taking into consideration, so that search can be faster. However, building an in-memory tree costs time and memory (to hold that data stucture), and it is redundant in real life, because query optimization should be a job of a database engine.
- To improve search speed when data set increase, we should use a proper DB. So we can rely on it indexes to make query faster.
- In memory cache or Redis cache of a search results might be helpful too, if the same search is reapeat frequently in the application.

5. Robustness
- Report errors for invalid commands, missing resources, invalid resources, invalid format, invalid query ...

6. Extras
- `-f` option to return different format. It is good if user can select output format that they need
- Pretty print results, errors with color. This will made CLI output easier to read
