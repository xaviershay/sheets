import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util

dest = "www/static"
targets =
  [ "hornpipe"
  , "all-we-got"
  ]

main :: IO ()
main = shakeArgs shakeOptions{shakeFiles=static} $ do
    want $ [
      dest </> target <.> extension |
        target <- targets,
        extension <- ["pdf", "midi"]
      ]

    phony "clean" $ do
        putNormal "Cleaning files"
        removeFilesAfter dest ["//*"]

    [dest <> "//*.pdf", dest <> "//*.midi"] &%> \[outp, outm] -> do
        let c = dropDirectory1 $ out -<.> "ly"
        let o = dropExtension outp
        cmd_ "lilypond" "-o" [outp] [c]
