import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util

dest = "www/static"

main :: IO ()
main = shakeArgs shakeOptions{shakeFiles="_build"} $ do
  want ["www/index.html"]

  phony "clean" $ do
    putNormal "Cleaning files"
    removeFilesAfter dest ["//*"]

  "www/index.html" %> \out -> do
    fs <- getDirectoryFiles "src/lilypond" ["*.ly"]
    let pdfs = ["www/static" </> (takeBaseName sourceFile) -<.> "pdf" | sourceFile <- fs]
    need pdfs

    cmd_ "cp" "src/www/index.html" "www/index.html"

  dest <> "//*.pdf" %> \outp -> do
    let c = "src/lilypond" </> (dropDirectory1 . dropDirectory1 $ outp -<.> "ly")
    let o = dropExtension outp
    cmd_ "lilypond" "-o" [o] [c]
