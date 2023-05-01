# How to build
## CLI
quarto preview

## R
quarto::quarto_render
quarto::quarto_preview

# Technical to-do:

* Broken links
* Images to markdown style
* Get SVGs working in pdf output - prob convert to pdf
* Make the search box prettier
* Glossary highlight only once per section
* Autolink to terms ?disease ?management
* Correct image size when column-margin images have captions
* Click on margin images to pop into centre screen
* Add scrolling radiology images
* Modify glossary to only scan words up to to maximum length in the glossary to speed up build time


# Content to-do:

* LP and spinal as distinct entities with incldues


# Decisions

* Where to put rhabdo, CIM, CIN
	* Rhabdo under fluid
	* CIM, CIN under neuromuscular

* Infection
	* Move system-specific infections to that system
	* New infective subgroups
		* ?where would TB meningitis go; under TB, separate neuro infection, under meningitis...
		* Where would CLABSI go...
		* NSTI
	* Dissolve "systemic" section

* Dissolve ICU 'concepts' into a more appropriate category (or at least some of, ?organ donation separately)

* Add a "goals" div to replace the info box in each management section

* ?Create integumentary section for osteomyelitis, NSTI, etc