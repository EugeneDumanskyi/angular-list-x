angular.module('listxModule').config ($provide) ->
    $provide.decorator 'listxTranslations', ($delegate) ->
        # extend default dictionary by adding new words
        $delegate['Default Template'] =
            en: 'Default Template'
            de: 'Standardvorlage'
            fr: 'Modèle par défaut'
            es: 'Plantilla Predeterminada'
            ru: 'Шаблон по умолчанию'
        $delegate
