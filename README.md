# List X widget for AngularJS & Bootstrap

## Basic example:

* CSS styles

`<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">`

* ng-app

`<body ng-app="myApp">`

* List markup

`<list-x ng-model="items" title="Default Template" load-url="test2.json"></list-x>`

* Corresponding scripts in the end of `<body>`

```
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min.js"></script>
<script src="../angular.listx.min.js"></script>
<!-- Define our module with corresponding dependencies -->
<script>angular.module('myApp', ['listxModule']);</script>
```

## For more information, see "examples" folder 

## License

MIT