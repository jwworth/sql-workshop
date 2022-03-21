# sql-workshop

This is material for Jack and Jake's SQL workshop at [Code Platoon][cp].

To see how the day will progress, check out the [Agenda][agenda].

### Setup

Clone the repo (no need to fork):

```
$ git clone https://github.com/jwworth/sql-workshop
```

Install [PostgreSQL][pg]. This is really important; please try to have a
working PostgreSQL REPL ready before we begin!

One way to verify a working Postgres installation would be to create and
connect to a Postgres database.

```
$ createdb deleteme
$ psql deleteme

psql (13.4)
Type "help" for help.

deleteme=# exit

$ dropdb deleteme
```

We'll start with the Phone Book domain.

```
$ cd sql-workshop/phone_book
```

Open up `lesson.sql` in your text editor.

### Additional Resources

You can't beat the official [PostgreSQL docs][pg-docs]; they are about as good
as documentation gets. This [conventions page][pg-conventions] will help you
read them.

We're proud to have contributed [PG Casts][pgcasts]. This series of videos
covers in greater detail many of the commands we'll teach today.

### License

This project is released under the [MIT License][mit].

### Sponsors

We are grateful to the following sponsors, who continue to support this
partnership:

- [CCSalesPro][cc]
- [Framebridge][fb]
- [Hashrocket][hr]

[agenda]: agenda.md
[cc]: https://www.ccsalespro.com/
[cp]: https://www.codeplatoon.org/
[fb]: https://www.framebridge.com/
[hr]: https://hashrocket.com/
[mit]: http://www.opensource.org/licenses/MIT
[pg-conventions]: https://www.postgresql.org/docs/current/notation.html
[pg-docs]: https://www.postgresql.org/docs/
[pg]: https://www.postgresql.org/
[pgcasts]: https://pgcasts.com/
