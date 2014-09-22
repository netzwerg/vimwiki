<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>%title%</title>
    <link rel="stylesheet" href="%root_path%%css%">
  <style>
    html {
      font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    }
    /*
       I am only interested in tables to create two-column lists of
       keyboard-shortcut/description entries. Enforcing the first column of
       all tables to be the same width, makes multiple lists appear consistent
       on any given page. 
     */  
    td:first-child {  
      min-width: 20%;
    }
  </style>
  </head>
  <body>
    <div class="container">%content%</div>
  </body>
</html>
