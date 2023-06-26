# How to build
## CLI
export QUARTO_DENO_EXTRA_OPTIONS=--v8-flags=--max-old-space-size=8192

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

* LP and spinal as distinct entities with includes
* Revise vasoactives in Part one and include a trimmed section for inotropes/dilators/pressors
	* Chapters in Oh's are quite good
* Move trials into separate stems
* Re-do the resuscitation section, particularly post-arrest care
* Revise sources of sepsis table


# Package to-do

Table editor:

* Simple table corner appropriate
* Grid table with split column/rows
* Tab to indent for bulleted lists
* Enter to put new line below this one, even if there is content in the row below
* Swap cell with cell above
* Swap row with row above but restricted to that cell alone


# Decisions

* Where to put:
	* Rhabdo, CIM, CIN
	* Rhabdo under fluid?
	* CIM, CIN under neuromuscular?
	* GvHD?
	* Structure of the immunological section

* Infection
	* Sepsis under management or as a disease? Colocate with neutropaenic sepsis/febrile neutropaenia?
	* Move system-specific infections to that system
	* New infective subgroups
		* ?where would TB meningitis go; under TB, separate neuro infection, under meningitis...
		* Where would CLABSI go...
		* NSTI
	* Dissolve "systemic" section

* Dissolve ICU 'concepts' into a more appropriate category (or at least some of, ?organ donation separately)

* ?Change pharmacological to prescription, to encompass fluids and blood, etc

* Fix acid-base assessment