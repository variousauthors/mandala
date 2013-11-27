mandala
=======

Mandala is for making interactive fiction that disintegrates the more people play it.

##Usage

Prepare your story with Twine, if you wish. For now mandala supports only a limited
twine vocabulary. To understand, you will have to read the code.

Once you have a twine, export it as markdown. The markdown files should go in
`db/content/` and should consist of at least two files: one should be called
`perimeter.md`, these are the starting rooms; the others can have any name.

With the rake task `prepare:content`, these markdown files can be prepared into yaml,
suitable to seed the database. One the yaml is prepared, your job is not finished.
To add hit-points to the passages, you must individually annotate them with a
number between bars. For example,

> One long hall, with a high ceiling of plain wood planks, is separated into four rooms by sliding shoji.|250|

Once this is done, seed the database in the normal manner and deploy.

When the database is seeded, and the mandala is deployed, then you must move the
markdown and the seeds.yaml file to a hidden place in a locked repo where no one
will be able to peek.

##ToDO

I need some way of "tapping" the site, to see how healthy it is without decrementing
any counters. Right now, inspecting the db is the only good way.

Twitter integration: I want what Sword & Sworcery and Nested have.
