# How to build
## CLI
export QUARTO_DENO_EXTRA_OPTIONS=--v8-flags=--max-old-space-size=65536

$env:QUARTO_DENO_EXTRA_OPTIONS="--v8-flags=--max-old-space-size=65536"

quarto preview

# Technical to-do:

* Broken links
* Images to markdown style
* Get SVGs working in pdf output - prob convert to png
* Make the search box prettier
* Glossary highlight only once per section
* Glossary expand to pdf output
* Change links from Chapter X to chapter title: leverage this? https://stackoverflow.com/questions/75071145/quarto-cross-references-persistent-cross-references-when-text-changes
* Autolink to terms ?disease ?management
* Click on margin images to pop into centre screen
* Add scrolling radiology images
* Modify glossary to only scan words up to to maximum length in the glossary to speed up build time
* Fix the mermaid theme
	* Get custom theme auto-applied to each graph
	* Prevent margin svgs from overflowing their boundaries

# Content to-do:

* LP and spinal as distinct entities with includes
* Revise vasoactives in Part one and include a trimmed section for inotropes/dilators/pressors
	* Chapters in Oh's are quite good
* Move trials into separate stems
* Re-do the resuscitation section, particularly post-arrest care
* Revise sources of sepsis table
* Revise antibiotics table with some useful PK/PD/tissue penetration things
* Move paeds anaesthesia to the concepts section and pyloromyotomy and inhaled FB to surgical sections
* Split out paeds ICU considerations into specific disease
* Try get rid of that non-breaking space after the chapter number in the top breadcrumbs


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
* Immune vs haeme? Combine them?
	* Consistency between disease and management

* Dissolve ICU 'concepts' into a more appropriate category (or at least some of, ?organ donation separately)

* ?Change pharmacological to prescription, to encompass fluids and blood, etc

* ?Split out anaemias

* Fix acid-base assessment


* ? Change clinical features to assessment, and split into hx/ex/ix/ddx (like the CICM glossary)
