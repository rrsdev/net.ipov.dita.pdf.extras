A very simple DITA-OT plugin for the PDF (formerly PDF2) output.

What this does:

Plugs into the dita.xsl.xslfo extension point and causes images
embedded into PDFs to be scaled to fit the PDF page.

Overall this is very useful, as the current PDF transform is simply embedding images as-is,
which often means they are cropped at the edge of the page.

The main problem I see with the current version of this code is that there is no
indication that the image has been scaled, maybe either a flag to log all scaled images,
or to add a small indicator of some sort would allow authors to review and tweak any
images where the scaling had created a major problem.