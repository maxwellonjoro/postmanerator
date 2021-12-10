[![Build Status](https://travis-ci.org/aubm/postmanerator.svg?branch=master)](https://travis-ci.org/aubm/postmanerator) [![Coverage Status](https://coveralls.io/repos/github/aubm/postmanerator/badge.svg?branch=master)](https://coveralls.io/github/aubm/postmanerator?branch=master)

## What is it?

Some guy said:

> How great would it be if we could use [Postman's](https://www.getpostman.com/) well-maintained collections to generate beautiful documentations with a single command?

Well guess what some guy, now you can use Postmanerator to do so! Can I?

Just download the [latest release on Github](https://github.com/aubm/postmanerator/releases/latest). You obviously need to pick the right binary depending on your environment. Then place that binary somewhere in your system that is in your PATH, you might want to rename it to simply `postmanerator`.

Afterwards, export your Postman collection, let's say in `$YOUR_PROJECT/postman/collection.json` and simply run:

```
postmanerator -output=./doc.html -collection=$YOUR_PROJECT/postman/collection.json
```

Or, if you're using Windows Powershell:

```
postmanerator --output=./doc.html --collection=$YOUR_PROJECT/postman/collection.json
```

Want to see the result? Take a look at [this example](http://aubm.github.io/Books-API/).
For the record, this documentation is automatically generated by Postmanerator and published on Github Pages using Travis. Feel free to have a [look at the source repository](https://github.com/aubm/Books-API).

## Configuration

There are chances that the "out-of-the-box" behavior is not good enough for you. Please consider using the following recommendations and command line options to ensure you get the result you expect.

- **Use relevant names and descriptions**: folders and requests names are used to create the structure of the generated documentation. You may want to use relevant headers. Furthermore, feel free to write good descriptions for your folders (documentation sections) and requests, as they will be rendered. You may be interested to know that the `default` theme will parse any [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) content found in descriptions.
- **Use saved responses**: all saved request's responses are rendered in the `default` theme. You may want to use them to show different potential responses to your users, like a "successfull" response or an "invalid data error" response.

### Provide a collection file

The collection is a JSON file generated from the Postman UI. You can get more information about Postman collection from the [official documentation](https://www.getpostman.com/docs/collections).

Use the `-collection=/path/to/collection.json` option to provide the collection to Postmanerator.

### Provide an environment file

The environment file is a JSON file generated from the Postman UI. You can get more information about Postman environments from the [official documentation](https://www.getpostman.com/docs/environments).

Use the `-environment=/path/to/environment.json` option to provide the environment to Postmanerator.

### Provide a theme

By default, Postmanerator will use its `default` theme, but you can change it by using the `-theme=theme_name` option.
You can either provide a theme name from the [official themes repository](https://github.com/aubm/postmanerator-themes), or a full local path to theme folder.

### Provide the output

By default, Postmanerator will print the generated output to the standard output. You can change that by providing a path to the `-output=/path/to/generated/doc.html` option.

### Prevent arbitrary request/response headers to be rendered

Maybe they are some request/response headers you don't want to see in your documentation. You can prevent Postmanerator to render them by providing comma seperated lists of headers to the following options:

```
-ignored-request-headers="Content-Type"
-ignored-response-headers="Content-Type,Content-Length"
```

## Define API structures

You may have noticed that API structures are documented at the beginning of [this example generated documentation](http://aubm.github.io/Books-API/). Therefore you might be interested to know that these elements are not hard coded in the theme. You actually have the ability to provide these information to Postmanerator. How's that? you asked.

If you know how to use Postman to automate integration tests, then you know that these test cases are written in Javascript. Knowing that, you can now use Javascript to define your API structures for Postmanerator. Consider the following code snippet inserted in any of your requests "Tests" pane:

```javascript
/*[[start postmanerator]]*/
function populateNewAPIStructures() {
    APIStructures['cat'] = {
        name: 'Cat',
        description: 'A great animal',
        fields: [
            {name: 'id', description: 'A unique identifier for the cat', type: 'int'},
            {name: 'color', description: 'The color of the cat', type: 'string'},
            {name: 'name', description: 'The name of the cat', type: 'string'}
        ]
    };
}
/*[[end postmanerator]]*/
```

The `/*[[start postmanerator]]*/` and `/*[[end postmanerator]]*/` delimiters are important, Postmanerator will search for these delimiters to identify the portion of Javascript it needs to interpret.

The name of the function `populateNewAPIStructures` is also important as Postmanerator will execute this exact function. You can define as many of these code snippets as you need, even in multiple independant requests.

When Postmanerator is done executing all the snippets, it will look for defined objects in the `APIStructures` global variable and make these structures definitions available for the theme.

## Themes

The whole point of Postmanerator is to be able to generate beautiful documentations from a Postman collection.
This is done by exposing the collection data with a few helpers to a theme. A theme contains an `index.tpl` file, this is the only requirement. However it could contain other templates or resources.

### List themes

If you want to know the list of themes that are available in your local environment, simply use the following command:

```
postmanerator themes list
```

The list of available themes will be printed out to the standard output. By default, themes are located under the `$USER_HOME/.postmanerator/themes` directory. If you want to change that, simply define the `POSTMANERATOR_PATH` environment variable.

### Download new themes

By now, you probably only have the `default` theme available, the `postmanerator themes get` command allows you download a new existing theme.
You can either specify the name of one of the themes that are indexed in the [official themes repository](https://github.com/aubm/postmanerator-themes), or either specify a full URL pointing to git repository. Moreover the `-theme-local-name` option allows you to change the name of your local copy of the theme. Please see the following examples.

```bash
postmanerator themes get markdown # will down the theme 'markdown' and copy it under your local themes directory in a folder named 'markdown'
postmanerator -theme-local-name="my-markdown" themes get markdown # will down the theme 'markdown' and copy it under your local themes directory in a folder named 'my-markdown'
postmanerator themes get https://github.com/aubm/postmanerator-markdown-theme.git # will clone the given repository under your local themes directory, in a folder named 'postmanerator-markdown-theme'
postmanerator -theme-local-name="markdown" themes get https://github.com/aubm/postmanerator-markdown-theme.git # will clone the given repository under your local themes directory, in a folder named 'markdown'
```

### Delete a theme

Use the following command to remove a theme from your local themes directory.

```
postmanerator themes delete markdown
```

### Create your own theme

So far, all we did was playing with existing themes. While this may be good enough, you may eventually want to customize the look of your documentation. A theme is really just a folder with an `index.tpl` inside, so starting your own one is not that difficult.

If you start from the existing `default`, which could be a good idea, you will notice that the syntax is pretty simple. In fact, if you have been writing some Go code, there are chances that you have been playing with the `template/text` package from the standard library.
If so, then good news: you (almost) already know everything you need to know to get started.
If not, don't worry, this is relatively easy to learn. Here is the [page from the documentation of the language](https://golang.org/pkg/text/template/).

While working on your theme, it will quickly become annoying to relaunch the `postmanerator` command each time you bring a change in the sources. To avoid that, you can use the `-watch` flag that will do the job for you.

```
postmanerator -output="/tmp/doc.html" -theme="my-custom-theme" -collection="collection.json" -watch
```

Postmanerator comes with some handy template helpers that you can use. Let's explore each one of them.

#### Find a response

To find a specific response for a given request, you can use the following helper:

```
{{ $res := findResponse $req "response name" }}
```

#### Parse markdown content

You can parse some Markdown content using the internal Markdown parser. Typically you may want to do that for the description of a folder or a request.

```
{{ $desc := markdown $req.Description }}
```

#### Format JSON

Sometimes, a JSON string contained somewhere in the collection in not properly formatted. Postmanerator can help you with that, by using the `indentJSON` helper. Using this helper, you can turn this:

```
{"firstname": "John", "lastname: "Doe"}
```

Into this:

```json
{
    "firstname": "John",
    "lastname": "Doe"
}
```

Here is how:

```
{{ $formattedJSON := indentJSON $res.RawData }}
```

#### Generate a Curl snippet

Postmanerator can generate a Curl snippet from a request, this can be really useful:

```
{{ curlSnippet $req }}
```

#### Generate a HTTP snippet

Alternatively, you can generate a HTTP snippet from a request:

```
{{ httpSnippet $req }}
```

#### Inline some content

Let's assume you are creating a HTML theme, at some point you may want to use libraries downloaded from some CDN like `highlightjs` or `jquery`. If so, it is also possible that you want your generated documentation to be fully functionnal even without an internet connexion.

To help you with that, Postmanerator can download some content on the web, and inline it in your template on the fly. Consider the following example:

```
<script>{{ inline "https://code.jquery.com/jquery-2.2.2.min.js" }}</script>
```

To inline local content, you can use to Golang built-in `template`:

```
<style>{{ template 'style.css' }}</style>
```

#### Generate URL friendly slugs from requests/folders names

To remove special chars and white spaces from an input string, you can use the following helper:

```
<a href="#{{ slugify $req.Name }}">{{ $req.Name }}</a>
```

#### Check for any content

If an endpoint of your API returns an empty response body, Postman may export that saved response body as a non-empty string `" "` or `"\n"`.
As a workaround, Postmanerator provides the `hasContent` helper which can be used as follow:

```
{{ if hasContent $res.Data }}
    <pre><code>{{ $res.Data }}</code></pre>
{{ end }}
```

## Installation

As said in the introduction, the easiest way to get it installed for now is to download the latest appropriate [release on Github](https://github.com/aubm/postmanerator/releases/latest), depending on your system. Then copy it somewhere in your PATH, renaming it to `postmanerator`.

Alternatively, you can download the source code and compile it by hand. The Go programming language has to be installed on your machine for that.

- Follow the instructions to [get the latest version of Golang installed](https://golang.org/doc/install) on your machine
- Download Postmanerator using go get: `go get github.com/aubm/postmanerator`
- Or download by forking/cloning this repo: `git clone github.com/your_username/postmanerator`
- Generate the binary with `go build`
- To use the binary: `postmanerator -output=./doc.html -collection=$YOUR_PROJECT/postman/collection.json`

There is also a community maintained docker image available, simply run:

```
docker run \
-v [YOUR-PROJECT-PATH]:/usr/var \
hughmp/postmanerator:latest \
-collection /usr/var/[YOUR-COLLECTION.JSON] \
-output /usr/var/[YOUR-HTML.html]
```

## Contributing

Contributions are welcome. Please refer to the [contributions guidelines](CONTRIBUTING.md) for more information.

## License

[MIT License](LICENSE.md)
