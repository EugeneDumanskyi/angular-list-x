angular.module('listxModule').config(function($provide) {
  return $provide.decorator('listxTranslations', function($delegate) {
    $delegate['Default Template'] = {
      en: 'Default Template',
      de: 'Standardvorlage',
      fr: 'Modèle par défaut',
      es: 'Plantilla Predeterminada',
      ru: 'Шаблон по умолчанию'
    };
    return $delegate;
  });
});

