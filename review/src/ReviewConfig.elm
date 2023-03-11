module ReviewConfig exposing (config)

{-| Do not rename the ReviewConfig module or the config function, because
`elm-review` will look for these.

To add packages that contain rules, add them to this review project using

    `elm install author/packagename`

when inside the directory containing this file.

-}

import NoDebug.Log
import NoExposingEverything
import NoImportingEverything
import NoInconsistentAliases
import NoLongImportLines
import NoMissingTypeAnnotation
import NoMissingTypeAnnotationInLetIn
import NoModuleOnExposedNames
import NoUnused.CustomTypeConstructors
import NoUnused.Dependencies
import NoUnused.Exports
import NoUnused.Modules
import NoUnused.Parameters
import NoUnused.Patterns
import NoUnused.Variables
import Review.Rule as Rule exposing (Rule)
import Simplify


config : List Rule
config =
    [ NoDebug.Log.rule
    , NoExposingEverything.rule |> Rule.ignoreErrorsForDirectories [ "tests" ]
    , NoImportingEverything.rule
        [ "NewRelic.AdditionalData"
        , "Graphql.Http"
        , "Graphql.Http.GraphqlError"
        , "Http"
        ]
        |> Rule.ignoreErrorsForDirectories [ "tests" ]
    , NoInconsistentAliases.config
        [ ( "NewRelic.AdditionalData", "AdditionalData" )
        , ( "Json.Decode", "JD" )
        , ( "Json.Encode", "JE" )
        ]
        |> NoInconsistentAliases.noMissingAliases
        |> NoInconsistentAliases.rule
    , NoLongImportLines.rule
    , NoMissingTypeAnnotation.rule
    , NoMissingTypeAnnotationInLetIn.rule
    , NoModuleOnExposedNames.rule
    , NoUnused.Variables.rule
    , NoUnused.CustomTypeConstructors.rule []
    , NoUnused.Dependencies.rule
    , NoUnused.Modules.rule
    , NoUnused.Exports.rule
    , NoUnused.Parameters.rule
    , NoUnused.Patterns.rule
    , Simplify.rule Simplify.defaults
    ]
