describe 'ListX directive', () ->
    element = scope = $compile = $rootScope = $controller = $templateCache = listxConfig = null

    beforeEach module 'listxModule'

    beforeEach module 'list-tpl'

    beforeEach inject (_$compile_, _$rootScope_, _$controller_, _$templateCache_, _listxConfig_) ->
        $compile = _$compile_
        $rootScope = _$rootScope_
        $templateCache = _$templateCache_
        listxConfig = _listxConfig_

        $rootScope.items = [
            text: 'Item 1'
            desc: 'Desc 1'
        ,
            text: 'Item 2'
            desc: 'Desc 2'
        ,
            text: 'Item 3'
            desc: 'Desc 3'
        ,
            text: 'Item 4'
            desc: 'Desc 4'
        ];

        element = $compile('<list-x ng-model="items" title="Test"></list-x>')($rootScope)
        $rootScope.$digest()
        scope = element.isolateScope()

        $controller = _$controller_ 'listxController',
            $scope: scope
            $element: element
            $attrs: {}
            $transclude: () -> null
            $templateCache: $templateCache
            listxConfig: listxConfig


    it 'Replaces the element with the appropriate content', () ->
        expect(element).toHaveClass "list-x-main"

    it 'Has correct title', () ->
        titleElement = element.find ':first-child'
        expect(titleElement).toHaveId "list-x-title"
        expect(titleElement[0].innerText.trim()).toEqual "Test"

    it 'Has a search bar', () ->
        searchBarElement = element.find '.search-bar'
        expect(searchBarElement).toExist()
        expect(searchBarElement.find 'input[type=search]').toExist()

    it 'Has the correct number of items', () ->
        listElement = element.find 'ul.list-x'
        expect(listElement).toExist()
        items = listElement.find 'li'
        expect(items).toHaveLength(4)

    describe 'List item', () ->
        it 'Has correct template', () ->
            items = element.find 'ul.list-x li'
            expect(items.find '.list-x-item').toExist()

    describe 'ListX Controller', () ->
        it 'Should be defined', () ->
            expect($controller).toBeDefined()

        it 'Has the correct configuration', () ->
            expect(scope.searchBarTemplate).toEqual listxConfig.searchBarTemplate
            expect(scope.itemsTemplate).toEqual listxConfig.itemsTemplate
            expect(scope.itemTemplate).toEqual listxConfig.itemTemplate

        it 'Should mark given item selected', () ->
            expect(scope.isSelected scope.ngModel[0]).toNotEqual 'active'
            scope.ngModel[0].selected = true
            expect(scope.isSelected scope.ngModel[0]).toEqual 'active'

        it 'Should select the item', () ->
            expect(scope.ngModel[1].selected).toBeUndefined()
            scope.selectItem scope.ngModel[1]
            expect(scope.ngModel[1].selected).toBeDefined()
            expect(scope.ngModel[i].selected).toBeUndefined() for i in [0..3] when i isnt 1

        it 'Should set the item\'s template', () ->
            $controller.setItemTemplate '<span>test</span>'
            expect(scope.itemTpl).toEqual true
            expect($templateCache.get 'listxItemTpl').toEqual '<span>test</span>'


describe 'translate filter', () ->
    transFilter = translations = lang = null

    beforeEach module 'listxModule'

    beforeEach () ->
        angular.module('listxModule').config ($provide) ->
            $provide.value 'listxLanguage', 'de'

    beforeEach inject (_translateFilter_, _listxTranslations_, _listxLanguage_) ->
        transFilter = _translateFilter_
        translations = _listxTranslations_
        lang = _listxLanguage_

    it 'should translate the specified text to selected language', () ->
        expect(transFilter 'Search').toEqual translations['Search']['de']
        expect(transFilter 'Search', 'fr').toEqual translations['Search']['fr']
