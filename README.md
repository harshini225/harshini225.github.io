# Jack Walker's Portfolio

See Github's instructions about [editing files in your repository](https://docs.github.com/en/repositories/working-with-files/managing-files/editing-files#editing-files-in-your-repository) for how to edit Github files directly in the browser.

## How to add a new article
The metadata for articles is stored in [src/_data/articles.json](https://github.com/ezhangy/jw-portfolio/blob/main/src/_data/articles.json). You can add a new article to the page by adding a new JSON object to the list. For example:
```json
{
      "title": "<article title>",
      "link": "<url to article>",
      "publication": "<publication>",
      "date": "<date in MM/DD/YY format>",
      "image": "<path to file image>"
}
```
The "image" attribute should be the filename of an image in the [src/assets](https://github.com/ezhangy/jw-portfolio/tree/main/src/assets) folder. 

Articles on the website will appear in the same order as in the `articles.json` file. 

## How to change about text
You can change the about text that appears after "Jack Walker" by editing [src/_data/aboutText.json](https://github.com/ezhangy/jw-portfolio/blob/main/src/_data/aboutText.json). 

## How to change social media links
You can change the social media links by editing [src/_data/socialMediaLinks.json](https://github.com/ezhangy/jw-portfolio/blob/main/src/_data/socialMediaLinks.json). For example, you might add the following object to the list: 
```json
{
    "name": "Facebook",
    "link": "<link to Facebook profile>"
}
```

## How to change site colors
You can change the site colors by editing the CSS variables in [src/styles.css](https://github.com/ezhangy/jw-portfolio/blob/main/src/styles.css). Look for the section at the top of the file that looks like this: 
```css
:root {
    --title-text-color: #2E3191;
    --gradient-start-color: #AFE3C0;
    --gradient-end-color: #EAF6FF;
    --article-text-color: #2E3191;
    --secondary-text-color: #0071BC;
}
```
To alter the site colors, replace the hex codes (#2E3191) with your desired hex code. 

