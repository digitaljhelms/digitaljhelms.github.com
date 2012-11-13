---
layout: post
title: "HTML Email Guidelines"
categories: []
tags: [html, email]
date: 2012-11-09 13:11:22
published: true
---
{% include JB/setup %}

I was recently asked to evaluate an HTML email newsletter template and provide my *professional* opinion. Unfortunately (or fortunately, however you want to look at it) I haven't done email development in nearly a decade. So, naturally, I conducted a bit of due diligence to base my opinion against, and to my surprise, not much has changed in the last decade as far as HTML email goes. Regardless, here are my findings, for posterities sake...

1. Mind your `HEAD`
   * **You can't avoid a `DOCTYPE`.** Many email clients strip your `DOCTYPE` and either impose their own or leave it out entirely. This means you need to test both with and without a `DOCTYPE` to ensure your syntax renders how it should.
   * **Don't embed in the `HEAD`.** Browser-based email services, like Gmail, Yahoo! Mail, Hotmail, etc., generally strip out `DOCTYPE`, `BODY`, and `HEAD` tags. Anything included within those tags, or as attributes on those tags (such as `bgcolor`, CSS, JavaScript, etc) runs the risk of being stripped.
2. Use tables for layout
   * **Set the width in each cell, not the table.** When you combine `table` widths, `td` widths, `td` padding and CSS padding into an email, the final result is different in almost every email client. The most reliable way to set the width of your table is to set a width for each cell, not for the table itself.
   * **Err toward nesting.** Table nesting is far more reliable than setting left and right margins or padding for table cells.
   * **Use a container table for body background colors.** Many email clients ignore background colors specified in your CSS or the `BODY` tag. To work around this, wrap your entire email with a 100% width table and give that a background color.
3. CSS and font formatting
   * **Do you best to avoid CSS altogether.** But, if CSS is a must, make sure you move your CSS inline and review the [list of CSS support](http://www.campaignmonitor.com/css/) across the major clients for a good idea of the safe properties and those that should be avoided.
   * **Avoid shorthand.** A number of email clients reject CSS shorthand for the font property as well as hex notation.
   * **Avoid using paragraphs.** If part of your design is height-sensitive and calls for pixel perfection, avoid the paragraph tag altogether and set the text formatting inline in a table cell.
   * **Link colors may be overwritten.** If link color is important to your design, can avoid it being "reset" by setting a default color for each link inline and then adding a redundant `span` inside the a tag.
4. Images in HTML
   * **Avoid spacer images.** Most email clients replace images with an empty placeholder in the same dimensions, others strip the image altogether. Stick to fixed cell widths to keep your formatting in place with or without images.
   * **Always include the dimensions of your image.** A number of clients will invent their own sizes when images are blocked and break your layout. Also, ensure that any images are correctly sized before adding them to your email; some email clients will ignore the dimensions specified in code and rely on the true dimensions of the image.
   * **Avoid PNG images.** Some email clients don't support 8-bit or 24-bit PNG images, so stick with the GIF or JPG.
   * **Don't use background images.** Some email clients have no support for background images. There are hacks to get full page background images working, but monkey-patching should be a last resort.
   * **Use the display hack for Hotmail.** Windows Live Hotmail adds a few pixels of additional padding below images. A workaround is to set `display:block` for images.
   * **Don't use floats.** Some email clients offer no support for the `float` property. Instead, use the `align` attribute of the `img` tag to float images in your email.
   * **Use absolute paths.** Images should be hosted on a publicly accessible web server and the image source should point to the full URL.
5. Video in email
   * **Quite simply, don't do it.** There is no support for JavaScript or the `object` tag in email and very few email clients support HTML5 video.
6. Think small
   * **Stay within the constraints of 550-650px.** Most people view messages in their preview panes, which are narrow and small; for instance, the preview pane in AOL 9 is less than 200 pixels wide. Templates designed by MailChimp and Campaign Monitor are never more than 600 pixels wide.
   <blockquote cite="http://www.campaignmonitor.com/blog/post/3481/how-wide-are-html-email-designs-today/">Many email client preview panes are still not suitable for emails exceeding 650px wide. Gauging from a purely non-scientific sample -- 467 reader votes received -- this seems to be common knowledge amongst designers: A whopping 74% of votes were for a maximum email width of 550-650px. 90% of this segment voted explicitly for a width of 600px.<br>-- <a href="http://www.campaignmonitor.com/blog/post/3481/how-wide-are-html-email-designs-today/">Campaign Monitor</a></blockquote>
   * **Mobile screens are much smaller.** The most common mobile email readers are in a range of 320px. The iPhone allows for a 300px width when held vertically and a 480px width in landscape mode. The iPhone also resize email content to fit the screen, but many other smart phones don't, so it makes sense to design for the lowest common denominator.
