angular.module 'listxModule', []

.value 'listxConfig',
    template: '/tpl/list-tpl.html'
    searchBarTemplate: '/tpl/search-bar-tpl.html'
    itemsTemplate: '/tpl/items-tpl.html'
    itemTemplate: '/tpl/item-tpl.html'

.value 'listxLanguage', 'en'

.value 'listxTranslations',
    Search:
        en: 'Search'
        de: 'Suche'
        fr: 'Rechercher'
        es: 'Buscar'
        ru: 'Поиск'

.filter 'translate', (listxLanguage, listxTranslations) ->
    (input, lang) ->
        try
            ret = listxTranslations[input][if lang then lang else listxLanguage]
        catch
            ret = input

.controller 'listxController', ($scope, $element, $attrs, $transclude, $templateCache, listxConfig) ->
        $scope.searchBarTemplate = listxConfig.searchBarTemplate
        $scope.itemsTemplate = listxConfig.itemsTemplate
        $scope.itemTemplate = listxConfig.itemTemplate
        $scope.itemTpl = false
        $scope.q = val: ''

        $scope.isSelected = (item) -> 'active' if item.selected

        $scope.overItem = (item) -> $scope.onMouseOver item:item

        $scope.leaveItem = (item) -> $scope.onMouseLeave item:item

        $scope.selectItem = (item) ->
            delete curItem.selected for curItem in $scope.ngModel when curItem.selected
            item.selected = true
            $scope.onSelect item:item

        this.setItemTemplate = (tpl, src) ->
            $scope.itemTpl = true
            $scope.itemTemplate = src if src
            $templateCache.put 'listxItemTpl', tpl
        null

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
        onSelect: '&'
        onLoad: '&'
        onMouseOver: '&'
        onMouseLeave: '&'

    templateUrl: (tElement, tAttrs) -> listxConfig.template

    controller: 'listxController'

    link: (scope, iElement, iAttrs, controller) ->
        if scope.loadUrl
            $http.get(scope.loadUrl).success (data) ->
                scope.ngModel = data
                scope.onLoad()
        $('.list-x-main div[ng-transclude]').remove()
        $('.list-x-main').removeAttr 'title'

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
