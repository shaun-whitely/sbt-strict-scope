let Scala = ./dependencies/Scala.dhall

in  { files =
        Scala.files
          Scala.Files::{
          , repo = "sbt-strict-scope"
          , scalaVersion = "2.12.15"
          , strictPluginOverride =
              -- This repo is the strict plugin, so we directly depend on our own source code
              Some
                ''
                Compile / unmanagedSourceDirectories += baseDirectory.value.getParentFile / "src" / "main" / "scala"
                ''
          , docker = Scala.Docker::{
            , updateRequires =
                Scala.Files.default.docker.updateRequires # [ "src" ]
            }
          }
    }
