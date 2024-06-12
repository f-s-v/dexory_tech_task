> Re:
> Dexory – Senior Full-Stack Engineer
> Coding Exercise

This is a very simple Ruby on Rails application implementing provided technical task

### How to run

You will need a Postgresql Database and a machine ready to run Ruby on Rails applications

Simply clone the code and run inside the app's directory

```
bundle install
rails db:create
rails db:migrate
rails s
```

### Import scans

The required API is on `/api/scans.json`, make a POST request to `http://localhost:3000/api/scans.json` like that (scan_import.json is the file provided with the task):

```
curl http://localhost:3000/api/scans.json -H 'Content-Type: application/json' -d @test/fixtures/files/scan_import.json
```

### Import report

Open in browser `http://localhost:3000`, click on "New Report", and then, in the form, select the report file and click on submit. You should see the report after the import.

Just in case, a sample erport is attached as a PDF file to the repo.

### Implementation Details

These are the things I'd been focused on.

* Scan import time — do not do N + 1 queries.
* Report import time — same problem
* Display the report – how to display items from two datasources without N + 1 queries: scans and reports.

For these requirements I've made a very simple relational database.
I've also added the `activerecord-import` get, it allows to do bulk create.
For the 3rd requirement a joint table is used.

All these things were covered by tests.

### Limitations

Due to limited spare time these things were made not in the best possible way:

* No workspaces abstraction
* Authentication/authorization - no auth for API, no auth for pages
* Styling of the whole website is non-existent — a few css rules over standard rails scaffolding
* No system tests and integration tests.
* No validation for forms, poor validation for API (that happened because `activerecord-import` does not support `accepts_nested_attributes_for` and standard Rails way to validate objects didn't for here).

