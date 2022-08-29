divs:
"wrapper"
  wrapper for all content, styling should probably be blank

"footer-col-wrapper"
  wrapper for all of the footer columns
  see: _includes/footer.html

"footer-col"
  footer column
  see: _includes/footer.html

"page-content"
  content wrapper for all pages
  see: layouts/default.html


"links-container"
  surrounding box for link header and links
  example in: _includes/links.html

"links-subcontainer"
  surrounding box for links
  example in: _includes/links.html

"staff"
  a single staff member
  example in: /staff (staff layout)

----

tables:
  example in: /lectures, /assignments
  (generated_table layout)

----

Editing Webpages (from Milda's doc)

Edit navigation

  To enforce which pages are added in what order to the top-level navigation, there is a variable in _config.yml called “header_pages” which takes the form of a list of markdown files.

Links

  In general, paths to files on the website should be of the form
  {{ path/relative/to/top/level/directory | relative_url }}
  In order to work both on local testing and in deployment

Creating and including a table

  Make a table called [[table name]].md in _tables. Follow the format of other tables in the directory. In particular, the front matter should have two variables:

  1. cols, which is a list of columns that the table should have, in order
  	      e.g.: cols: [“Date”, “Title”]
  2. contents, which is a list of dictionaries representing the rows of the table. each key-value pair in the dictionary matches a column name to a list of strings or dictionaries representing links. Link paths should be relative to the top-level directory of the repo.
          e.g.: contents: [
               {
                 “Date”: [“01/01/01”],
                 “Title”: [“Title1”, “Title2”]
               },
               {
                 “Date”: [“12/31/00”],
                 “Title”: [{“this title is a link”:
                            “path/to/link”}]
               }
             ]


    Now you can include it in any markdown file by adding:

    {% include tables_helper.html name=”[[table name]]” %}
