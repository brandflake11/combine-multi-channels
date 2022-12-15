;; combine-multi-audio-channels
;; This file Copyright (C) 2022 Brandon Hale

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.


;; You need to have CM-INCUDINE installed. Normal CM just won't do.
;; Incudine is used for realtime and osc


;; This is my attempt to rewrite combineMultiChannels.py
;; into a lisp codebase
(defpackage :combine-multi-channels
  (:use :common-lisp :py4cl)
  (:export
   #:python-path
   #:combine-audio))

(in-package :combine-multi-channels)

;; To import this file, the file needs to be in the python path
(py4cl:import-module "combineMultiChannels" :as "combo")
;; To see what directories are in your current python path:

(defun python-path ()
  "Print out the directories in python's path."
  (py4cl:python-exec "import sys")
  (py4cl:python-eval "sys.path"))

;; Then copy the relevant file there.

;; Example after importing module
;; This will flip the channels from a test.wav to another.wav 
;; (combo:combinemultfns '("/tmp/test.wav") '((1 0)) "/tmp/another.wav")

(defun combine-audio (file-list channel-list new-file)
  "Combines multiple audio file channels into a new file based on channel-list.
file-list: include a list of filenames
channel-list: include a list of integers, these will be the channels wanted from each item of File-list. Each list refers to items of file-list.
new-file: path of the new file.

Example:

Say we have three stereo audio files, *one*, *two*, and *three*:
(combine-audio (list *one* *two* *three*) '(0 1 0) \"/tmp/output.wav\")

The output file will include in order:
Left Channel of *one*
Right Channel of *two*
Left Channel of *three*
Creating a 3 channel audio file.

You can also include multiple channels of a certain file, by putting a list in the channel-list:
(combine-audio (list *one* *two* *three*) '((0 1) 0 (1 0)) \"/tmp/output2.wav\")

The output file will include in order:
Left Channel of *one*
Right Channel of *one*
Left Channel of *two*
Right Channel of *three*
Left Channel of *three*
Creating a 4 channel file.

One last thing to remember, if you get confused: COMBINE-AUDIO does not mix channels. It only combines channels into a multichannel file, never mixing channels together. It will only separate out discrete files and reconstruct them.
"
  (labels ((listify (input)
	     "Turns input into a list if input is not a list. If it is, return input unchanged."
	     (if (not (listp input))
		 (list input)
		 input)))
    (let ((the-file-list file-list)
	  (the-channel-list (mapcar #'listify (listify channel-list))))
      (combo:combinemultfns the-file-list the-channel-list new-file))))

;; This is how you do it manually like in python
;; Only here for debugging:
;; (py4cl:python-eval "combo.combineMultFns(['/tmp/test.wav'],[[1,0]],'/tmp/another.wav')")
