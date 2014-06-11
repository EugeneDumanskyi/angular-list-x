describe 'ListX directive', () ->
    element = $compile =  $rootScope = $controller = $templateCache = listxConfig = null

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

        $controller = _$controller_ 'listxController',
            $scope: $rootScope
            $element: element
            $attrs: {}
            $transclude: () -> null
            $templateCache: $templateCache
            listxConfig: listxConfig

    describe 'ListX Controller', () ->
        it 'Has correct configuration', () ->
            expect($rootScope.searchBarTemplate).toEqual listxConfig.searchBarTemplate
            expect($rootScope.itemsTemplate).toEqual listxConfig.itemsTemplate
            expect($rootScope.itemTemplate).toEqual listxConfig.itemTemplate

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

    it 'Has correct number of items', () ->
        listElement = element.find 'ul.list-x'
        expect(listElement).toExist()
        items = listElement.find 'li'
        expect(items).toHaveLength(4)

        describe 'List item', () ->
            it 'Has correct template', () ->
                expect(items.find '.list-x-item').toExist()