angular.module 'listxModule', []

.value 'listxConfig',
    template: '/tpl/list-tpl.html'
    searchBarTemplate: '/tpl/search-bar-tpl.html'
    itemsTemplate: '/tpl/items-tpl.html'
    itemTemplate: '/tpl/item-tpl.html'

.directive 'listX', ['$http', '$templateCache', 'listxConfig', ($http, $templateCache, listxConfig) ->
    restrict: 'E'
    transclude: true
    replace: true
    require: 'ngModel'
    scope:
        title: '@'
        hideSearchBar: '@'
        itemHandlers: '&'
        loadUrl: '@'
        ngModel: '='
        onClick: '&'

    templateUrl: (tElement, tAttrs) -> listxConfig.template

    controller: ($scope, $element, $attrs, $transclude) ->
        $scope.searchBarTemplate = listxConfig.searchBarTemplate
        $scope.itemsTemplate = listxConfig.itemsTemplate
        $scope.itemTemplate = listxConfig.itemTemplate
        $scope.itemTpl = false
        $scope.q = val: ''

        $scope.isSelected = (item) -> 'active' if item.selected

        $scope.selectItem = (item) ->
            delete curItem.selected for curItem in $scope.ngModel when curItem.selected
            item.selected = true
            $scope.onClick item:item

        this.setItemTemplate = (tpl, src) ->
            $scope.itemTpl = true
            $scope.itemTemplate = src if src
            $templateCache.put 'itemtpl', tpl
        null

    link: (scope, iElement, iAttrs, controller) ->
        if scope.loadUrl
            $http.get(scope.loadUrl).success (data) -> scope.ngModel = data
        $('.list-x-main div[ng-transclude]').remove()
]


.directive 'itemTemplate', () ->
    restrict: 'E'
    replace: true
    transclude: true
    require: '^listX'
    scope:
        itemTemplate: '@'
    template: '<div ng-transclude></div>'

    link: (scope, iElement, iAttrs, controller) ->
        controller.setItemTemplate iElement.html(), scope.itemsTemplate
