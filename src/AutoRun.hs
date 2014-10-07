-- Automatically execute source code in multiple languages, with docker.
-- Copyright (C) 2014 Pedro Tacla Yamada
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
module AutoRun where

import System.Directory (getCurrentDirectory)
import System.FilePath ((</>), isAbsolute, takeDirectory, takeExtension)
import System.Process (system)

data RunTarget = RunTarget { imageName :: String
                           , command   :: String
                           , absPath   :: FilePath
                           , extension :: String
                           }
  deriving(Eq, Read, Show)

getRunTarget :: FilePath -> FilePath -> RunTarget
getRunTarget cwd fp | ext == ".js" = RunTarget "node:latest" "node" fp' ext
                    | otherwise    = error $ "Unsupported extension " ++ ext
  where fp' = if isAbsolute fp then fp else cwd </> fp
        ext = takeExtension fp

dockerRun :: RunTarget -> IO ()
dockerRun (RunTarget img cmd afp ext) = do
    let tfp = "/autorun-target" ++ ext
        runCmd = "docker run -i -t -v " ++ afp ++ ":" ++ tfp

    _ <- system $ unwords [ runCmd, img, cmd, tfp ]
    return ()

autorun :: FilePath -> IO ()
autorun fp = do
    cwd <- getCurrentDirectory
    dockerRun $ getRunTarget cwd fp
