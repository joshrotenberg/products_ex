{application,ex_cldr,
             [{applications,[kernel,stdlib,elixir,logger,decimal,cldr_utils]},
              {description,"Common Locale Data Repository (CLDR) functions for Elixir to localize and format numbers,\ndates, lists and units with support for over 500 locales for internationalized (i18n) and\nlocalized (L10N) applications.\n"},
              {modules,['Elixir.Cldr','Elixir.Cldr.AcceptLanguage',
                        'Elixir.Cldr.AcceptLanguageError',
                        'Elixir.Cldr.Backend','Elixir.Cldr.Backend.Compiler',
                        'Elixir.Cldr.Config','Elixir.Cldr.Config.Dependents',
                        'Elixir.Cldr.FormatCompileError',
                        'Elixir.Cldr.FormatError',
                        'Elixir.Cldr.Gettext.Plural','Elixir.Cldr.Install',
                        'Elixir.Cldr.InvalidDateFormatType',
                        'Elixir.Cldr.InvalidDateTimeFormatType',
                        'Elixir.Cldr.InvalidLanguageTag',
                        'Elixir.Cldr.InvalidTimeFormatType',
                        'Elixir.Cldr.LanguageTag',
                        'Elixir.Cldr.LanguageTag.ParseError',
                        'Elixir.Cldr.LanguageTag.Parser','Elixir.Cldr.Locale',
                        'Elixir.Cldr.Locale.Cache',
                        'Elixir.Cldr.NoDefaultBackendError',
                        'Elixir.Cldr.NoMatchingLocale',
                        'Elixir.Cldr.Number.PluralRule',
                        'Elixir.Cldr.Number.PluralRule.Compiler',
                        'Elixir.Cldr.Number.PluralRule.Transformer',
                        'Elixir.Cldr.Plug.AcceptLanguage',
                        'Elixir.Cldr.Plug.SetLocale',
                        'Elixir.Cldr.Rbnf.Config',
                        'Elixir.Cldr.Rbnf.NotAvailable',
                        'Elixir.Cldr.Rfc5646.Core',
                        'Elixir.Cldr.Rfc5646.Grammar',
                        'Elixir.Cldr.Rfc5646.Helpers',
                        'Elixir.Cldr.Rfc5646.Parser',
                        'Elixir.Cldr.Substitution','Elixir.Cldr.Timezone',
                        'Elixir.Cldr.UnknownCalendarError',
                        'Elixir.Cldr.UnknownCurrencyError',
                        'Elixir.Cldr.UnknownFormatError',
                        'Elixir.Cldr.UnknownLocaleError',
                        'Elixir.Cldr.UnknownNumberSystemError',
                        'Elixir.Cldr.UnknownNumberSystemTypeError',
                        'Elixir.Cldr.UnknownOTPAppError',
                        'Elixir.Cldr.UnknownPluralRules',
                        'Elixir.Cldr.UnknownTerritoryError',
                        'Elixir.Cldr.UnknownUnitError',
                        'Elixir.Jason.Encoder.Cldr.LanguageTag',
                        'Elixir.Mix.Tasks.Compile.Cldr',plural_rules_lexer,
                        plural_rules_parser]},
              {registered,[]},
              {vsn,"2.13.0"}]}.