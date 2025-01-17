// Extracted from https://html.spec.whatwg.org/multipage/indices.html
//           and  https://w3c.github.io/aria/
// Plus manually written (the last part about event handlers

[Exposed=Window]
interface AudioTrackList : EventTarget {
  readonly attribute unsigned long length;
  getter AudioTrack (unsigned long index);
  AudioTrack? getTrackById(DOMString id);

  attribute EventHandler onchange;
  attribute EventHandler onaddtrack;
  attribute EventHandler onremovetrack;
};

[Exposed=Window]
interface AudioTrack {
  readonly attribute DOMString id;
  readonly attribute DOMString kind;
  readonly attribute DOMString label;
  readonly attribute DOMString language;
  attribute boolean enabled;
};

[Exposed=Window]
interface BarProp {
  readonly attribute boolean visible;
};

[Exposed=Window]
interface BeforeUnloadEvent : Event {
  attribute DOMString returnValue;
};

[Exposed=(Window,Worker)]
interface BroadcastChannel : EventTarget {
  constructor(DOMString name);

  readonly attribute DOMString name;
  undefined postMessage(any message);
  undefined close();
  attribute EventHandler onmessage;
  attribute EventHandler onmessageerror;
};

[Exposed=(Window,Worker)]
interface CloseEvent : Event {
  constructor(DOMString type, optional CloseEventInit eventInitDict = {});

  readonly attribute boolean wasClean;
  readonly attribute unsigned short code;
  readonly attribute USVString reason;
};

dictionary CloseEventInit : EventInit {
  boolean wasClean = false;
  unsigned short code = 0;
  USVString reason = "";
};

[Exposed=Window]
interface CustomElementRegistry {
  [CEReactions] undefined define(DOMString name, CustomElementConstructor constructor, optional ElementDefinitionOptions options = {});
  (CustomElementConstructor or undefined) get(DOMString name);
  Promise<CustomElementConstructor> whenDefined(DOMString name);
  [CEReactions] undefined upgrade(Node root);
};

callback CustomElementConstructor = HTMLElement ();

dictionary ElementDefinitionOptions {
  DOMString extends;
};

[Exposed=Window]
interface DOMParser {
  constructor();

  [NewObject] Document parseFromString(DOMString string, DOMParserSupportedType type);
};

enum DOMParserSupportedType {
  "text/html",
  "text/xml",
  "application/xml",
  "application/xhtml+xml",
  "image/svg+xml"
};

[Exposed=(Window,Worker)]
interface DOMStringList {
  readonly attribute unsigned long length;
  getter DOMString? item(unsigned long index);
  boolean contains(DOMString string);
};

[Exposed=Window,
 LegacyOverrideBuiltIns]
interface DOMStringMap {
  getter DOMString (DOMString name);
  [CEReactions] setter undefined (DOMString name, DOMString value);
  [CEReactions] deleter undefined (DOMString name);
};

[Exposed=Window]
interface DataTransfer {
  constructor();

  attribute DOMString dropEffect;
  attribute DOMString effectAllowed;

  [SameObject] readonly attribute DataTransferItemList items;

  undefined setDragImage(Element image, long x, long y);

  /* old interface */
  readonly attribute FrozenArray<DOMString> types;
  DOMString getData(DOMString format);
  undefined setData(DOMString format, DOMString data);
  undefined clearData(optional DOMString format);
  [SameObject] readonly attribute FileList files;
};

[Exposed=Window]
interface DataTransferItem {
  readonly attribute DOMString kind;
  readonly attribute DOMString type;
  undefined getAsString(FunctionStringCallback? _callback);
  File? getAsFile();
};

callback FunctionStringCallback = undefined (DOMString data);

[Exposed=Window]
interface DataTransferItemList {
  readonly attribute unsigned long length;
  getter DataTransferItem (unsigned long index);
  DataTransferItem? add(DOMString data, DOMString type);
  DataTransferItem? add(File data);
  undefined remove(unsigned long index);
  undefined clear();
};

[Global=(Worker,DedicatedWorker),Exposed=DedicatedWorker]
interface DedicatedWorkerGlobalScope : WorkerGlobalScope {
  [Replaceable] readonly attribute DOMString name;

  undefined postMessage(any message, sequence<object> transfer);
  undefined postMessage(any message, optional PostMessageOptions options = {});

  undefined close();

  attribute EventHandler onmessage;
  attribute EventHandler onmessageerror;
};

enum DocumentReadyState { "loading", "interactive", "complete" };
typedef (HTMLScriptElement or SVGScriptElement) HTMLOrSVGScriptElement;

[LegacyOverrideBuiltIns]
partial interface Document {
  // resource metadata management
  [PutForwards=href, LegacyUnforgeable] readonly attribute Location? location;
  attribute USVString domain;
  readonly attribute USVString referrer;
  attribute USVString cookie;
  readonly attribute DOMString lastModified;
  readonly attribute DocumentReadyState readyState;

  // DOM tree accessors
  getter object (DOMString name);
  [CEReactions] attribute DOMString title;
  [CEReactions] attribute DOMString dir;
  [CEReactions] attribute HTMLElement? body;
  readonly attribute HTMLHeadElement? head;
  [SameObject] readonly attribute HTMLCollection images;
  [SameObject] readonly attribute HTMLCollection embeds;
  [SameObject] readonly attribute HTMLCollection plugins;
  [SameObject] readonly attribute HTMLCollection links;
  [SameObject] readonly attribute HTMLCollection forms;
  [SameObject] readonly attribute HTMLCollection scripts;
  NodeList getElementsByName(DOMString elementName);
  readonly attribute HTMLOrSVGScriptElement? currentScript; // classic scripts in a document tree only

  // dynamic markup insertion
  [CEReactions] Document open(optional DOMString unused1, optional DOMString unused2); // both arguments are ignored
  WindowProxy? open(USVString url, DOMString name, DOMString features);
  [CEReactions] undefined close();
  [CEReactions] undefined write(DOMString... text);
  [CEReactions] undefined writeln(DOMString... text);

  // user interaction
  readonly attribute WindowProxy? defaultView;
  boolean hasFocus();
  [CEReactions] attribute DOMString designMode;
  [CEReactions] boolean execCommand(DOMString commandId, optional boolean showUI = false, optional DOMString value = "");
  boolean queryCommandEnabled(DOMString commandId);
  boolean queryCommandIndeterm(DOMString commandId);
  boolean queryCommandState(DOMString commandId);
  boolean queryCommandSupported(DOMString commandId);
  DOMString queryCommandValue(DOMString commandId);

  // special event handler IDL attributes that only apply to Document objects
  [LegacyLenientThis] attribute EventHandler onreadystatechange;

  // also has obsolete members
};
Document includes GlobalEventHandlers;
Document includes DocumentAndElementEventHandlers;

interface mixin WindowEventHandlers {
  attribute EventHandler onafterprint;
  attribute EventHandler onbeforeprint;
  attribute OnBeforeUnloadEventHandler onbeforeunload;
  attribute EventHandler onhashchange;
  attribute EventHandler onlanguagechange;
  attribute EventHandler onmessage;
  attribute EventHandler onmessageerror;
  attribute EventHandler onoffline;
  attribute EventHandler ononline;
  attribute EventHandler onpagehide;
  attribute EventHandler onpageshow;
  attribute EventHandler onpopstate;
  attribute EventHandler onrejectionhandled;
  attribute EventHandler onstorage;
  attribute EventHandler onunhandledrejection;
  attribute UIEventHandler? onunload;
};

interface mixin DocumentAndElementEventHandlers {
  attribute EventHandler oncopy;
  attribute EventHandler oncut;
  attribute EventHandler onpaste;
};

[Exposed=Window]
interface DragEvent : MouseEvent {
  constructor(DOMString type, optional DragEventInit eventInitDict = {});

  readonly attribute DataTransfer? dataTransfer;
};

dictionary DragEventInit : MouseEventInit {
  DataTransfer? dataTransfer = null;
};

[Exposed=Window]
interface ElementInternals {
  // Shadow root access
  readonly attribute ShadowRoot? shadowRoot;

  // Form-associated custom elements
  undefined setFormValue((File or USVString or FormData)? value,
                         optional (File or USVString or FormData)? state);

  readonly attribute HTMLFormElement? form;

  undefined setValidity(optional ValidityStateFlags flags = {},
                        optional DOMString message,
                        optional HTMLElement anchor);
  readonly attribute boolean willValidate;
  readonly attribute ValidityState validity;
  readonly attribute DOMString validationMessage;
  boolean checkValidity();
  boolean reportValidity();

  readonly attribute NodeList labels;
};

// Accessibility semantics
ElementInternals includes ARIAMixin;

dictionary ValidityStateFlags {
  boolean valueMissing = false;
  boolean typeMismatch = false;
  boolean patternMismatch = false;
  boolean tooLong = false;
  boolean tooShort = false;
  boolean rangeUnderflow = false;
  boolean rangeOverflow = false;
  boolean stepMismatch = false;
  boolean badInput = false;
  boolean customError = false;
};

[Exposed=(Window,Worker)]
interface ErrorEvent : Event {
  constructor(DOMString type, optional ErrorEventInit eventInitDict = {});

  readonly attribute DOMString message;
  readonly attribute USVString filename;
  readonly attribute unsigned long lineno;
  readonly attribute unsigned long colno;
  readonly attribute any error;
};

dictionary ErrorEventInit : EventInit {
  DOMString message = "";
  USVString filename = "";
  unsigned long lineno = 0;
  unsigned long colno = 0;
  any error = null;
};

[Exposed=(Window,Worker)]
interface EventSource : EventTarget {
  constructor(USVString url, optional EventSourceInit eventSourceInitDict = {});

  readonly attribute USVString url;
  readonly attribute boolean withCredentials;

  // ready state
  const unsigned short CONNECTING = 0;
  const unsigned short OPEN = 1;
  const unsigned short CLOSED = 2;
  readonly attribute unsigned short readyState;

  // networking
  attribute EventHandler onopen;
  attribute EventHandler onmessage;
  attribute EventHandler onerror;
  undefined close();
};

dictionary EventSourceInit {
  boolean withCredentials = false;
};

[Exposed=Window]
interface External {
  undefined AddSearchProvider();
  undefined IsSearchProviderInstalled();
};

[Exposed=Window]
interface Plugin {
  readonly attribute undefined name;
  readonly attribute undefined description;
  readonly attribute undefined filename;
  readonly attribute undefined length;
  getter undefined item(unsigned long index);
  undefined namedItem(DOMString name);
};

[Exposed=Window]
interface FormDataEvent : Event {
  constructor(DOMString type, FormDataEventInit eventInitDict);

  readonly attribute FormData formData;
};

dictionary FormDataEventInit : EventInit {
  required FormData formData;
};

partial interface Document {
  [CEReactions] attribute [LegacyNullToEmptyString] DOMString fgColor;
  [CEReactions] attribute [LegacyNullToEmptyString] DOMString linkColor;
  [CEReactions] attribute [LegacyNullToEmptyString] DOMString vlinkColor;
  [CEReactions] attribute [LegacyNullToEmptyString] DOMString alinkColor;
  [CEReactions] attribute [LegacyNullToEmptyString] DOMString bgColor;

  [SameObject] readonly attribute HTMLCollection anchors;
  [SameObject] readonly attribute HTMLCollection applets;

  undefined clear();
  undefined captureEvents();
  undefined releaseEvents();

  [SameObject] readonly attribute HTMLAllCollection all;
};

[Exposed=Window,
 LegacyUnenumerableNamedProperties]
interface HTMLAllCollection {
  readonly attribute unsigned long length;
  getter Element (unsigned long index);
  getter (HTMLCollection or Element)? namedItem(DOMString name);
  (HTMLCollection or Element)? item(optional DOMString nameOrIndex);

  // Note: HTMLAllCollection objects have a custom [[Call]] internal method and an [[IsHTMLDDA]] internal slot.
};

[Exposed=Window]
interface HTMLAnchorElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString target;
  [CEReactions] attribute DOMString download;
  [CEReactions] attribute USVString ping;
  [CEReactions] attribute DOMString rel;
  [SameObject, PutForwards=value] readonly attribute DOMTokenList relList;
  [CEReactions] attribute DOMString hreflang;
  [CEReactions] attribute DOMString type;

  [CEReactions] attribute DOMString text;

  [CEReactions] attribute DOMString referrerPolicy;

  // also has obsolete members
};
HTMLAnchorElement includes HTMLHyperlinkElementUtils;

partial interface HTMLAnchorElement {
  [CEReactions] attribute DOMString coords;
  [CEReactions] attribute DOMString charset;
  [CEReactions] attribute DOMString name;
  [CEReactions] attribute DOMString rev;
  [CEReactions] attribute DOMString shape;
};

partial interface HTMLAreaElement {
  [CEReactions] attribute boolean noHref;
};

partial interface HTMLBodyElement {
  [CEReactions] attribute [LegacyNullToEmptyString] DOMString text;
  [CEReactions] attribute [LegacyNullToEmptyString] DOMString link;
  [CEReactions] attribute [LegacyNullToEmptyString] DOMString vLink;
  [CEReactions] attribute [LegacyNullToEmptyString] DOMString aLink;
  [CEReactions] attribute [LegacyNullToEmptyString] DOMString bgColor;
  [CEReactions] attribute DOMString background;
};

[Exposed=Window]
interface HTMLAreaElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString alt;
  [CEReactions] attribute DOMString coords;
  [CEReactions] attribute DOMString shape;
  [CEReactions] attribute DOMString target;
  [CEReactions] attribute DOMString download;
  [CEReactions] attribute USVString ping;
  [CEReactions] attribute DOMString rel;
  [SameObject, PutForwards=value] readonly attribute DOMTokenList relList;
  [CEReactions] attribute DOMString referrerPolicy;

  // also has obsolete members
};
HTMLAreaElement includes HTMLHyperlinkElementUtils;

[Exposed=Window,
 LegacyFactoryFunction=Audio(optional DOMString src)]
interface HTMLAudioElement : HTMLMediaElement {
  [HTMLConstructor] constructor();
};

[Exposed=Window]
interface HTMLBRElement : HTMLElement {
  [HTMLConstructor] constructor();

  // also has obsolete members
};

partial interface HTMLBRElement {
  [CEReactions] attribute DOMString clear;
};

[Exposed=Window]
interface HTMLBaseElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute USVString href;
  [CEReactions] attribute DOMString target;
};

[Exposed=Window]
interface HTMLBodyElement : HTMLElement {
  [HTMLConstructor] constructor();

  // also has obsolete members
};

HTMLBodyElement includes WindowEventHandlers;

[Exposed=Window]
interface HTMLButtonElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute boolean disabled;
  readonly attribute HTMLFormElement? form;
  [CEReactions] attribute USVString formAction;
  [CEReactions] attribute DOMString formEnctype;
  [CEReactions] attribute DOMString formMethod;
  [CEReactions] attribute boolean formNoValidate;
  [CEReactions] attribute DOMString formTarget;
  [CEReactions] attribute DOMString name;
  [CEReactions] attribute DOMString type;
  [CEReactions] attribute DOMString value;

  readonly attribute boolean willValidate;
  readonly attribute ValidityState validity;
  readonly attribute DOMString validationMessage;
  boolean checkValidity();
  boolean reportValidity();
  undefined setCustomValidity(DOMString error);

  readonly attribute NodeList labels;
};

typedef (CanvasRenderingContext2D or ImageBitmapRenderingContext or WebGLRenderingContext or WebGL2RenderingContext) RenderingContext;

[Exposed=Window]
interface HTMLCanvasElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute unsigned long width;
  [CEReactions] attribute unsigned long height;

  RenderingContext? getContext(DOMString contextId, optional any options = null);

  USVString toDataURL(optional DOMString type = "image/png", optional any quality);
  undefined toBlob(BlobCallback _callback, optional DOMString type = "image/png", optional any quality);
  OffscreenCanvas transferControlToOffscreen();
};

callback BlobCallback = undefined (Blob? blob);

[Exposed=Window]
interface HTMLDListElement : HTMLElement {
  [HTMLConstructor] constructor();

  // also has obsolete members
};

partial interface HTMLDListElement {
  [CEReactions] attribute boolean compact;
};

[Exposed=Window]
interface HTMLDataElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString value;
};

[Exposed=Window]
interface HTMLDataListElement : HTMLElement {
  [HTMLConstructor] constructor();

  [SameObject] readonly attribute HTMLCollection options;
};

[Exposed=Window]
interface HTMLDetailsElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute boolean open;
};

[Exposed=Window]
interface HTMLDialogElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute boolean open;
  attribute DOMString returnValue;
  [CEReactions] undefined show();
  [CEReactions] undefined showModal();
  [CEReactions] undefined close(optional DOMString returnValue);
};

[Exposed=Window]
interface HTMLDirectoryElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute boolean compact;
};

[Exposed=Window]
interface HTMLDivElement : HTMLElement {
  [HTMLConstructor] constructor();

  // also has obsolete members
};

partial interface HTMLDivElement {
  [CEReactions] attribute DOMString align;
};

[Exposed=Window]
interface HTMLElement : Element {
  [HTMLConstructor] constructor();

  // metadata attributes
  [CEReactions] attribute DOMString title;
  [CEReactions] attribute DOMString lang;
  [CEReactions] attribute boolean translate;
  [CEReactions] attribute DOMString dir;

  // user interaction
  [CEReactions] attribute boolean hidden;
  undefined click();
  [CEReactions] attribute DOMString accessKey;
  readonly attribute DOMString accessKeyLabel;
  [CEReactions] attribute boolean draggable;
  [CEReactions] attribute boolean spellcheck;
  [CEReactions] attribute DOMString autocapitalize;

  [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerText;

  ElementInternals attachInternals();
};

HTMLElement includes GlobalEventHandlers;
HTMLElement includes DocumentAndElementEventHandlers;
HTMLElement includes ElementContentEditable;
HTMLElement includes HTMLOrSVGElement;

[Exposed=Window]
interface HTMLEmbedElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute USVString src;
  [CEReactions] attribute DOMString type;
  [CEReactions] attribute DOMString width;
  [CEReactions] attribute DOMString height;
  Document? getSVGDocument();

  // also has obsolete members
};

partial interface HTMLEmbedElement {
  [CEReactions] attribute DOMString align;
  [CEReactions] attribute DOMString name;
};

[Exposed=Window]
interface HTMLFieldSetElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute boolean disabled;
  readonly attribute HTMLFormElement? form;
  [CEReactions] attribute DOMString name;

  readonly attribute DOMString type;

  [SameObject] readonly attribute HTMLCollection elements;

  readonly attribute boolean willValidate;
  [SameObject] readonly attribute ValidityState validity;
  readonly attribute DOMString validationMessage;
  boolean checkValidity();
  boolean reportValidity();
  undefined setCustomValidity(DOMString error);
};

[Exposed=Window]
interface HTMLFontElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute [LegacyNullToEmptyString] DOMString color;
  [CEReactions] attribute DOMString face;
  [CEReactions] attribute DOMString size;
};

[Exposed=Window]
interface HTMLFormControlsCollection : HTMLCollection {
  // inherits length and item()
  getter (RadioNodeList or Element)? namedItem(DOMString name); // shadows inherited namedItem()
};

[Exposed=Window]
interface RadioNodeList : NodeList {
  attribute DOMString value;
};

[Exposed=Window,
 LegacyOverrideBuiltIns,
 LegacyUnenumerableNamedProperties]
interface HTMLFormElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString acceptCharset;
  [CEReactions] attribute USVString action;
  [CEReactions] attribute DOMString autocomplete;
  [CEReactions] attribute DOMString enctype;
  [CEReactions] attribute DOMString encoding;
  [CEReactions] attribute DOMString method;
  [CEReactions] attribute DOMString name;
  [CEReactions] attribute boolean noValidate;
  [CEReactions] attribute DOMString target;
  [CEReactions] attribute DOMString rel;
  [SameObject, PutForwards=value] readonly attribute DOMTokenList relList;

  [SameObject] readonly attribute HTMLFormControlsCollection elements;
  readonly attribute unsigned long length;
  getter Element (unsigned long index);
  getter (RadioNodeList or Element) (DOMString name);

  undefined submit();
  undefined requestSubmit(optional HTMLElement? submitter = null);
  [CEReactions] undefined reset();
  boolean checkValidity();
  boolean reportValidity();
};

[Exposed=Window]
interface HTMLFrameElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString name;
  [CEReactions] attribute DOMString scrolling;
  [CEReactions] attribute USVString src;
  [CEReactions] attribute DOMString frameBorder;
  [CEReactions] attribute USVString longDesc;
  [CEReactions] attribute boolean noResize;
  readonly attribute Document? contentDocument;
  readonly attribute WindowProxy? contentWindow;

  [CEReactions] attribute [LegacyNullToEmptyString] DOMString marginHeight;
  [CEReactions] attribute [LegacyNullToEmptyString] DOMString marginWidth;
};

[Exposed=Window]
interface HTMLFrameSetElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString cols;
  [CEReactions] attribute DOMString rows;
};
HTMLFrameSetElement includes WindowEventHandlers;

[Exposed=Window]
interface HTMLHRElement : HTMLElement {
  [HTMLConstructor] constructor();

  // also has obsolete members
};

partial interface HTMLHRElement {
  [CEReactions] attribute DOMString align;
  [CEReactions] attribute DOMString color;
  [CEReactions] attribute boolean noShade;
  [CEReactions] attribute DOMString size;
  [CEReactions] attribute DOMString width;
};

[Exposed=Window]
interface HTMLHeadElement : HTMLElement {
  [HTMLConstructor] constructor();
};

[Exposed=Window]
interface HTMLHeadingElement : HTMLElement {
  [HTMLConstructor] constructor();

  // also has obsolete members
};

partial interface HTMLHeadingElement {
  [CEReactions] attribute DOMString align;
};

[Exposed=Window]
interface HTMLHtmlElement : HTMLElement {
  [HTMLConstructor] constructor();

  // also has obsolete members
};

partial interface HTMLHtmlElement {
  [CEReactions] attribute DOMString version;
};

[Exposed=Window]
interface HTMLIFrameElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute USVString src;
  [CEReactions] attribute DOMString srcdoc;
  [CEReactions] attribute DOMString name;
  [SameObject, PutForwards=value] readonly attribute DOMTokenList sandbox;
  [CEReactions] attribute DOMString allow;
  [CEReactions] attribute boolean allowFullscreen;
  [CEReactions] attribute DOMString width;
  [CEReactions] attribute DOMString height;
  [CEReactions] attribute DOMString referrerPolicy;
  [CEReactions] attribute DOMString loading;
  readonly attribute Document? contentDocument;
  readonly attribute WindowProxy? contentWindow;
  Document? getSVGDocument();

  // also has obsolete members
};

partial interface HTMLIFrameElement {
  [CEReactions] attribute DOMString align;
  [CEReactions] attribute DOMString scrolling;
  [CEReactions] attribute DOMString frameBorder;
  [CEReactions] attribute USVString longDesc;

  [CEReactions] attribute [LegacyNullToEmptyString] DOMString marginHeight;
  [CEReactions] attribute [LegacyNullToEmptyString] DOMString marginWidth;
};

[Exposed=Window,
 LegacyFactoryFunction=Image(optional unsigned long width, optional unsigned long height)]
interface HTMLImageElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString alt;
  [CEReactions] attribute USVString src;
  [CEReactions] attribute USVString srcset;
  [CEReactions] attribute DOMString sizes;
  [CEReactions] attribute DOMString? crossOrigin;
  [CEReactions] attribute DOMString useMap;
  [CEReactions] attribute boolean isMap;
  [CEReactions] attribute unsigned long width;
  [CEReactions] attribute unsigned long height;
  readonly attribute unsigned long naturalWidth;
  readonly attribute unsigned long naturalHeight;
  readonly attribute boolean complete;
  readonly attribute USVString currentSrc;
  [CEReactions] attribute DOMString referrerPolicy;
  [CEReactions] attribute DOMString decoding;
  [CEReactions] attribute DOMString loading;

  Promise<undefined> decode();

  // also has obsolete members
};

partial interface HTMLImageElement {
  [CEReactions] attribute DOMString name;
  [CEReactions] attribute USVString lowsrc;
  [CEReactions] attribute DOMString align;
  [CEReactions] attribute unsigned long hspace;
  [CEReactions] attribute unsigned long vspace;
  [CEReactions] attribute USVString longDesc;

  [CEReactions] attribute [LegacyNullToEmptyString] DOMString border;
};

[Exposed=Window]
interface HTMLInputElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString accept;
  [CEReactions] attribute DOMString alt;
  [CEReactions] attribute DOMString autocomplete;
  [CEReactions] attribute boolean defaultChecked;
  attribute boolean checked;
  [CEReactions] attribute DOMString dirName;
  [CEReactions] attribute boolean disabled;
  readonly attribute HTMLFormElement? form;
  attribute FileList? files;
  [CEReactions] attribute USVString formAction;
  [CEReactions] attribute DOMString formEnctype;
  [CEReactions] attribute DOMString formMethod;
  [CEReactions] attribute boolean formNoValidate;
  [CEReactions] attribute DOMString formTarget;
  [CEReactions] attribute unsigned long height;
  attribute boolean indeterminate;
  readonly attribute HTMLElement? list;
  [CEReactions] attribute DOMString max;
  [CEReactions] attribute long maxLength;
  [CEReactions] attribute DOMString min;
  [CEReactions] attribute long minLength;
  [CEReactions] attribute boolean multiple;
  [CEReactions] attribute DOMString name;
  [CEReactions] attribute DOMString pattern;
  [CEReactions] attribute DOMString placeholder;
  [CEReactions] attribute boolean readOnly;
  [CEReactions] attribute boolean required;
  [CEReactions] attribute unsigned long size;
  [CEReactions] attribute USVString src;
  [CEReactions] attribute DOMString step;
  [CEReactions] attribute DOMString type;
  [CEReactions] attribute DOMString defaultValue;
  [CEReactions] attribute [LegacyNullToEmptyString] DOMString value;
  attribute object? valueAsDate;
  attribute unrestricted double valueAsNumber;
  [CEReactions] attribute unsigned long width;

  undefined stepUp(optional long n = 1);
  undefined stepDown(optional long n = 1);

  readonly attribute boolean willValidate;
  readonly attribute ValidityState validity;
  readonly attribute DOMString validationMessage;
  boolean checkValidity();
  boolean reportValidity();
  undefined setCustomValidity(DOMString error);

  readonly attribute NodeList? labels;

  undefined select();
  attribute unsigned long? selectionStart;
  attribute unsigned long? selectionEnd;
  attribute DOMString? selectionDirection;
  undefined setRangeText(DOMString replacement);
  undefined setRangeText(DOMString replacement, unsigned long start, unsigned long end, optional SelectionMode selectionMode = "preserve");
  undefined setSelectionRange(unsigned long start, unsigned long end, optional DOMString direction);

  // also has obsolete members
};

partial interface HTMLInputElement {
  [CEReactions] attribute DOMString align;
  [CEReactions] attribute DOMString useMap;
};

[Exposed=Window]
interface HTMLLIElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute long value;

  // also has obsolete members
};

partial interface HTMLLIElement {
  [CEReactions] attribute DOMString type;
};

[Exposed=Window]
interface HTMLLabelElement : HTMLElement {
  [HTMLConstructor] constructor();

  readonly attribute HTMLFormElement? form;
  [CEReactions] attribute DOMString htmlFor;
  readonly attribute HTMLElement? control;
};

[Exposed=Window]
interface HTMLLegendElement : HTMLElement {
  [HTMLConstructor] constructor();

  readonly attribute HTMLFormElement? form;

  // also has obsolete members
};

partial interface HTMLLegendElement {
  [CEReactions] attribute DOMString align;
};

[Exposed=Window]
interface HTMLLinkElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute USVString href;
  [CEReactions] attribute DOMString? crossOrigin;
  [CEReactions] attribute DOMString rel;
  [CEReactions] attribute DOMString as; // (default "")
  [SameObject, PutForwards=value] readonly attribute DOMTokenList relList;
  [CEReactions] attribute DOMString media;
  [CEReactions] attribute DOMString integrity;
  [CEReactions] attribute DOMString hreflang;
  [CEReactions] attribute DOMString type;
  [SameObject, PutForwards=value] readonly attribute DOMTokenList sizes;
  [CEReactions] attribute USVString imageSrcset;
  [CEReactions] attribute DOMString imageSizes;
  [CEReactions] attribute DOMString referrerPolicy;
  [CEReactions] attribute boolean disabled;

  // also has obsolete members
};
HTMLLinkElement includes LinkStyle;

partial interface HTMLLinkElement {
  [CEReactions] attribute DOMString charset;
  [CEReactions] attribute DOMString rev;
  [CEReactions] attribute DOMString target;
};

[Exposed=Window]
interface HTMLMapElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString name;
  [SameObject] readonly attribute HTMLCollection areas;
};

[Exposed=Window]
interface HTMLMarqueeElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString behavior;
  [CEReactions] attribute DOMString bgColor;
  [CEReactions] attribute DOMString direction;
  [CEReactions] attribute DOMString height;
  [CEReactions] attribute unsigned long hspace;
  [CEReactions] attribute long loop;
  [CEReactions] attribute unsigned long scrollAmount;
  [CEReactions] attribute unsigned long scrollDelay;
  [CEReactions] attribute boolean trueSpeed;
  [CEReactions] attribute unsigned long vspace;
  [CEReactions] attribute DOMString width;

  undefined start();
  undefined stop();
};

enum CanPlayTypeResult { "" /* empty string */, "maybe", "probably" };
typedef (MediaStream or MediaSource or Blob) MediaProvider;

[Exposed=Window]
interface HTMLMediaElement : HTMLElement {

  // error state
  readonly attribute MediaError? error;

  // network state
  [CEReactions] attribute USVString src;
  attribute MediaProvider? srcObject;
  readonly attribute USVString currentSrc;
  [CEReactions] attribute DOMString? crossOrigin;
  const unsigned short NETWORK_EMPTY = 0;
  const unsigned short NETWORK_IDLE = 1;
  const unsigned short NETWORK_LOADING = 2;
  const unsigned short NETWORK_NO_SOURCE = 3;
  readonly attribute unsigned short networkState;
  [CEReactions] attribute DOMString preload;
  readonly attribute TimeRanges buffered;
  undefined load();
  CanPlayTypeResult canPlayType(DOMString type);

  // ready state
  const unsigned short HAVE_NOTHING = 0;
  const unsigned short HAVE_METADATA = 1;
  const unsigned short HAVE_CURRENT_DATA = 2;
  const unsigned short HAVE_FUTURE_DATA = 3;
  const unsigned short HAVE_ENOUGH_DATA = 4;
  readonly attribute unsigned short readyState;
  readonly attribute boolean seeking;

  // playback state
  attribute double currentTime;
  undefined fastSeek(double time);
  readonly attribute unrestricted double duration;
  object getStartDate();
  readonly attribute boolean paused;
  attribute double defaultPlaybackRate;
  attribute double playbackRate;
  attribute boolean preservesPitch;
  readonly attribute TimeRanges played;
  readonly attribute TimeRanges seekable;
  readonly attribute boolean ended;
  [CEReactions] attribute boolean autoplay;
  [CEReactions] attribute boolean loop;
  Promise<undefined> play();
  undefined pause();

  // controls
  [CEReactions] attribute boolean controls;
  attribute double volume;
  attribute boolean muted;
  [CEReactions] attribute boolean defaultMuted;

  // tracks
  [SameObject] readonly attribute AudioTrackList audioTracks;
  [SameObject] readonly attribute VideoTrackList videoTracks;
  [SameObject] readonly attribute TextTrackList textTracks;
  TextTrack addTextTrack(TextTrackKind kind, optional DOMString label = "", optional DOMString language = "");
};

[Exposed=Window]
interface HTMLMenuElement : HTMLElement {
  [HTMLConstructor] constructor();

  // also has obsolete members
};

partial interface HTMLMenuElement {
  [CEReactions] attribute boolean compact;
};

[Exposed=Window]
interface HTMLMetaElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString name;
  [CEReactions] attribute DOMString httpEquiv;
  [CEReactions] attribute DOMString content;

  // also has obsolete members
};

partial interface HTMLMetaElement {
  [CEReactions] attribute DOMString scheme;
};

[Exposed=Window]
interface HTMLMeterElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute double value;
  [CEReactions] attribute double min;
  [CEReactions] attribute double max;
  [CEReactions] attribute double low;
  [CEReactions] attribute double high;
  [CEReactions] attribute double optimum;
  readonly attribute NodeList labels;
};

[Exposed=Window]
interface HTMLModElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute USVString cite;
  [CEReactions] attribute DOMString dateTime;
};

[Exposed=Window]
interface HTMLOListElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute boolean reversed;
  [CEReactions] attribute long start;
  [CEReactions] attribute DOMString type;

  // also has obsolete members
};

partial interface HTMLOListElement {
  [CEReactions] attribute boolean compact;
};

[Exposed=Window]
interface HTMLObjectElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute USVString data;
  [CEReactions] attribute DOMString type;
  [CEReactions] attribute DOMString name;
  readonly attribute HTMLFormElement? form;
  [CEReactions] attribute DOMString width;
  [CEReactions] attribute DOMString height;
  readonly attribute Document? contentDocument;
  readonly attribute WindowProxy? contentWindow;
  Document? getSVGDocument();

  readonly attribute boolean willValidate;
  readonly attribute ValidityState validity;
  readonly attribute DOMString validationMessage;
  boolean checkValidity();
  boolean reportValidity();
  undefined setCustomValidity(DOMString error);

  // also has obsolete members
};

partial interface HTMLObjectElement {
  [CEReactions] attribute DOMString align;
  [CEReactions] attribute DOMString archive;
  [CEReactions] attribute DOMString code;
  [CEReactions] attribute boolean declare;
  [CEReactions] attribute unsigned long hspace;
  [CEReactions] attribute DOMString standby;
  [CEReactions] attribute unsigned long vspace;
  [CEReactions] attribute DOMString codeBase;
  [CEReactions] attribute DOMString codeType;
  [CEReactions] attribute DOMString useMap;

  [CEReactions] attribute [LegacyNullToEmptyString] DOMString border;
};

[Exposed=Window]
interface HTMLOptGroupElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute boolean disabled;
  [CEReactions] attribute DOMString label;
};

[Exposed=Window,
 LegacyFactoryFunction=Option(optional DOMString text = "", optional DOMString value, optional boolean defaultSelected = false, optional boolean selected = false)]
interface HTMLOptionElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute boolean disabled;
  readonly attribute HTMLFormElement? form;
  [CEReactions] attribute DOMString label;
  [CEReactions] attribute boolean defaultSelected;
  attribute boolean selected;
  [CEReactions] attribute DOMString value;

  [CEReactions] attribute DOMString text;
  readonly attribute long index;
};

[Exposed=Window]
interface HTMLOptionsCollection : HTMLCollection {
  // inherits item(), namedItem()
  [CEReactions] attribute unsigned long length; // shadows inherited length
  [CEReactions] setter undefined (unsigned long index, HTMLOptionElement? option);
  [CEReactions] undefined add((HTMLOptionElement or HTMLOptGroupElement) element, optional (HTMLElement or long)? before = null);
  [CEReactions] undefined remove(long index);
  attribute long selectedIndex;
};

[Exposed=Window]
interface HTMLOutputElement : HTMLElement {
  [HTMLConstructor] constructor();

  [SameObject, PutForwards=value] readonly attribute DOMTokenList htmlFor;
  readonly attribute HTMLFormElement? form;
  [CEReactions] attribute DOMString name;

  readonly attribute DOMString type;
  [CEReactions] attribute DOMString defaultValue;
  [CEReactions] attribute DOMString value;

  readonly attribute boolean willValidate;
  readonly attribute ValidityState validity;
  readonly attribute DOMString validationMessage;
  boolean checkValidity();
  boolean reportValidity();
  undefined setCustomValidity(DOMString error);

  readonly attribute NodeList labels;
};

[Exposed=Window]
interface HTMLParagraphElement : HTMLElement {
  [HTMLConstructor] constructor();

  // also has obsolete members
};

partial interface HTMLParagraphElement {
  [CEReactions] attribute DOMString align;
};

[Exposed=Window]
interface HTMLParamElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString name;
  [CEReactions] attribute DOMString value;

  // also has obsolete members
};

partial interface HTMLParamElement {
  [CEReactions] attribute DOMString type;
  [CEReactions] attribute DOMString valueType;
};

[Exposed=Window]
interface HTMLPictureElement : HTMLElement {
  [HTMLConstructor] constructor();
};

[Exposed=Window]
interface HTMLPreElement : HTMLElement {
  [HTMLConstructor] constructor();

  // also has obsolete members
};

partial interface HTMLPreElement {
  [CEReactions] attribute long width;
};

[Exposed=Window]
interface HTMLProgressElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute double value;
  [CEReactions] attribute double max;
  readonly attribute double position;
  readonly attribute NodeList labels;
};

[Exposed=Window]
interface HTMLQuoteElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute USVString cite;
};

[Exposed=Window]
interface HTMLScriptElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute USVString src;
  [CEReactions] attribute DOMString type;
  [CEReactions] attribute boolean noModule;
  [CEReactions] attribute boolean async;
  [CEReactions] attribute boolean defer;
  [CEReactions] attribute DOMString? crossOrigin;
  [CEReactions] attribute DOMString text;
  [CEReactions] attribute DOMString integrity;
  [CEReactions] attribute DOMString referrerPolicy;

  // also has obsolete members
};

partial interface HTMLScriptElement {
  [CEReactions] attribute DOMString charset;
  [CEReactions] attribute DOMString event;
  [CEReactions] attribute DOMString htmlFor;
};

[Exposed=Window]
interface HTMLSelectElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString autocomplete;
  [CEReactions] attribute boolean disabled;
  readonly attribute HTMLFormElement? form;
  [CEReactions] attribute boolean multiple;
  [CEReactions] attribute DOMString name;
  [CEReactions] attribute boolean required;
  [CEReactions] attribute unsigned long size;

  readonly attribute DOMString type;

  [SameObject] readonly attribute HTMLOptionsCollection options;
  [CEReactions] attribute unsigned long length;
  getter Element? item(unsigned long index);
  HTMLOptionElement? namedItem(DOMString name);
  [CEReactions] undefined add((HTMLOptionElement or HTMLOptGroupElement) element, optional (HTMLElement or long)? before = null);
  [CEReactions] undefined remove(); // ChildNode overload
  [CEReactions] undefined remove(long index);
  [CEReactions] setter undefined (unsigned long index, HTMLOptionElement? option);

  [SameObject] readonly attribute HTMLCollection selectedOptions;
  attribute long selectedIndex;
  attribute DOMString value;

  readonly attribute boolean willValidate;
  readonly attribute ValidityState validity;
  readonly attribute DOMString validationMessage;
  boolean checkValidity();
  boolean reportValidity();
  undefined setCustomValidity(DOMString error);

  readonly attribute NodeList labels;
};

[Exposed=Window]
interface HTMLSlotElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString name;
  sequence<Node> assignedNodes(optional AssignedNodesOptions options = {});
  sequence<Element> assignedElements(optional AssignedNodesOptions options = {});
};

dictionary AssignedNodesOptions {
  boolean flatten = false;
};

[Exposed=Window]
interface HTMLSourceElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute USVString src;
  [CEReactions] attribute DOMString type;
  [CEReactions] attribute USVString srcset;
  [CEReactions] attribute DOMString sizes;
  [CEReactions] attribute DOMString media;
  [CEReactions] attribute unsigned long width;
  [CEReactions] attribute unsigned long height;
};

[Exposed=Window]
interface HTMLSpanElement : HTMLElement {
  [HTMLConstructor] constructor();
};

[Exposed=Window]
interface HTMLStyleElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString media;

  // also has obsolete members
};
HTMLStyleElement includes LinkStyle;

partial interface HTMLStyleElement {
  [CEReactions] attribute DOMString type;
};


[Exposed=Window]
interface HTMLTableCaptionElement : HTMLElement {
  [HTMLConstructor] constructor();

  // also has obsolete members
};

partial interface HTMLTableCaptionElement {
  [CEReactions] attribute DOMString align;
};

[Exposed=Window]
interface HTMLTableCellElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute unsigned long colSpan;
  [CEReactions] attribute unsigned long rowSpan;
  [CEReactions] attribute DOMString headers;
  readonly attribute long cellIndex;

  [CEReactions] attribute DOMString scope; // only conforming for th elements
  [CEReactions] attribute DOMString abbr;  // only conforming for th elements

  // also has obsolete members
};

partial interface HTMLTableCellElement {
  [CEReactions] attribute DOMString align;
  [CEReactions] attribute DOMString axis;
  [CEReactions] attribute DOMString height;
  [CEReactions] attribute DOMString width;

  [CEReactions] attribute DOMString ch;
  [CEReactions] attribute DOMString chOff;
  [CEReactions] attribute boolean noWrap;
  [CEReactions] attribute DOMString vAlign;

  [CEReactions] attribute [LegacyNullToEmptyString] DOMString bgColor;
};

[Exposed=Window]
interface HTMLTableColElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute unsigned long span;

  // also has obsolete members
};

partial interface HTMLTableColElement {
  [CEReactions] attribute DOMString align;
  [CEReactions] attribute DOMString ch;
  [CEReactions] attribute DOMString chOff;
  [CEReactions] attribute DOMString vAlign;
  [CEReactions] attribute DOMString width;
};

[Exposed=Window]
interface HTMLTableElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute HTMLTableCaptionElement? caption;
  HTMLTableCaptionElement createCaption();
  [CEReactions] undefined deleteCaption();

  [CEReactions] attribute HTMLTableSectionElement? tHead;
  HTMLTableSectionElement createTHead();
  [CEReactions] undefined deleteTHead();

  [CEReactions] attribute HTMLTableSectionElement? tFoot;
  HTMLTableSectionElement createTFoot();
  [CEReactions] undefined deleteTFoot();

  [SameObject] readonly attribute HTMLCollection tBodies;
  HTMLTableSectionElement createTBody();

  [SameObject] readonly attribute HTMLCollection rows;
  HTMLTableRowElement insertRow(optional long index = -1);
  [CEReactions] undefined deleteRow(long index);

  // also has obsolete members
};

partial interface HTMLTableElement {
  [CEReactions] attribute DOMString align;
  [CEReactions] attribute DOMString border;
  [CEReactions] attribute DOMString frame;
  [CEReactions] attribute DOMString rules;
  [CEReactions] attribute DOMString summary;
  [CEReactions] attribute DOMString width;

  [CEReactions] attribute [LegacyNullToEmptyString] DOMString bgColor;
  [CEReactions] attribute [LegacyNullToEmptyString] DOMString cellPadding;
  [CEReactions] attribute [LegacyNullToEmptyString] DOMString cellSpacing;
};

[Exposed=Window]
interface HTMLTableRowElement : HTMLElement {
  [HTMLConstructor] constructor();

  readonly attribute long rowIndex;
  readonly attribute long sectionRowIndex;
  [SameObject] readonly attribute HTMLCollection cells;
  HTMLTableCellElement insertCell(optional long index = -1);
  [CEReactions] undefined deleteCell(long index);

  // also has obsolete members
};

partial interface HTMLTableRowElement {
  [CEReactions] attribute DOMString align;
  [CEReactions] attribute DOMString ch;
  [CEReactions] attribute DOMString chOff;
  [CEReactions] attribute DOMString vAlign;

  [CEReactions] attribute [LegacyNullToEmptyString] DOMString bgColor;
};

[Exposed=Window]
interface HTMLTableSectionElement : HTMLElement {
  [HTMLConstructor] constructor();

  [SameObject] readonly attribute HTMLCollection rows;
  HTMLTableRowElement insertRow(optional long index = -1);
  [CEReactions] undefined deleteRow(long index);

  // also has obsolete members
};

partial interface HTMLTableSectionElement {
  [CEReactions] attribute DOMString align;
  [CEReactions] attribute DOMString ch;
  [CEReactions] attribute DOMString chOff;
  [CEReactions] attribute DOMString vAlign;
};

[Exposed=Window]
interface HTMLTemplateElement : HTMLElement {
  [HTMLConstructor] constructor();

  readonly attribute DocumentFragment content;
};

[Exposed=Window]
interface HTMLTextAreaElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString autocomplete;
  [CEReactions] attribute unsigned long cols;
  [CEReactions] attribute DOMString dirName;
  [CEReactions] attribute boolean disabled;
  readonly attribute HTMLFormElement? form;
  [CEReactions] attribute long maxLength;
  [CEReactions] attribute long minLength;
  [CEReactions] attribute DOMString name;
  [CEReactions] attribute DOMString placeholder;
  [CEReactions] attribute boolean readOnly;
  [CEReactions] attribute boolean required;
  [CEReactions] attribute unsigned long rows;
  [CEReactions] attribute DOMString wrap;

  readonly attribute DOMString type;
  [CEReactions] attribute DOMString defaultValue;
  attribute [LegacyNullToEmptyString] DOMString value;
  readonly attribute unsigned long textLength;

  readonly attribute boolean willValidate;
  readonly attribute ValidityState validity;
  readonly attribute DOMString validationMessage;
  boolean checkValidity();
  boolean reportValidity();
  undefined setCustomValidity(DOMString error);

  readonly attribute NodeList labels;

  undefined select();
  attribute unsigned long selectionStart;
  attribute unsigned long selectionEnd;
  attribute DOMString selectionDirection;
  undefined setRangeText(DOMString replacement);
  undefined setRangeText(DOMString replacement, unsigned long start, unsigned long end, optional SelectionMode selectionMode = "preserve");
  undefined setSelectionRange(unsigned long start, unsigned long end, optional DOMString direction);
};

[Exposed=Window]
interface HTMLTimeElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString dateTime;
};

[Exposed=Window]
interface HTMLTitleElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString text;
};

[Exposed=Window]
interface HTMLTrackElement : HTMLElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute DOMString kind;
  [CEReactions] attribute USVString src;
  [CEReactions] attribute DOMString srclang;
  [CEReactions] attribute DOMString label;
  [CEReactions] attribute boolean default;

  const unsigned short NONE = 0;
  const unsigned short LOADING = 1;
  const unsigned short LOADED = 2;
  const unsigned short ERROR = 3;
  readonly attribute unsigned short readyState;

  readonly attribute TextTrack track;
};

[Exposed=Window]
interface HTMLUListElement : HTMLElement {
  [HTMLConstructor] constructor();

  // also has obsolete members
};

partial interface HTMLUListElement {
  [CEReactions] attribute boolean compact;
  [CEReactions] attribute DOMString type;
};

[Exposed=Window]
interface HTMLUnknownElement : HTMLElement {
  // Note: intentionally no [HTMLConstructor]
};

[Exposed=Window]
interface HTMLVideoElement : HTMLMediaElement {
  [HTMLConstructor] constructor();

  [CEReactions] attribute unsigned long width;
  [CEReactions] attribute unsigned long height;
  readonly attribute unsigned long videoWidth;
  readonly attribute unsigned long videoHeight;
  [CEReactions] attribute USVString poster;
  [CEReactions] attribute boolean playsInline;
};

[Exposed=Window]
interface HashChangeEvent : Event {
  constructor(DOMString type, optional HashChangeEventInit eventInitDict = {});

  readonly attribute USVString oldURL;
  readonly attribute USVString newURL;
};

dictionary HashChangeEventInit : EventInit {
  USVString oldURL = "";
  USVString newURL = "";
};

enum ScrollRestoration { "auto", "manual" };

[Exposed=Window]
interface History {
  readonly attribute unsigned long length;
  attribute ScrollRestoration scrollRestoration;
  readonly attribute any state;
  undefined go(optional long delta = 0);
  undefined back();
  undefined forward();
  undefined pushState(any data, DOMString unused, optional USVString? url = null);
  undefined replaceState(any data, DOMString unused, optional USVString? url = null);
};

[Exposed=(Window,Worker), Serializable, Transferable]
interface ImageBitmap {
  readonly attribute unsigned long width;
  readonly attribute unsigned long height;
  undefined close();
};

typedef (CanvasImageSource or
         Blob or
         ImageData) ImageBitmapSource;

enum ImageOrientation { "none", "flipY" };
enum PremultiplyAlpha { "none", "premultiply", "default" };
enum ColorSpaceConversion { "none", "default" };
enum ResizeQuality { "pixelated", "low", "medium", "high" };

dictionary ImageBitmapOptions {
  ImageOrientation imageOrientation = "none";
  PremultiplyAlpha premultiplyAlpha = "default";
  ColorSpaceConversion colorSpaceConversion = "default";
  [EnforceRange] unsigned long resizeWidth;
  [EnforceRange] unsigned long resizeHeight;
  ResizeQuality resizeQuality = "low";
};

[Exposed=(Window,Worker)]
interface ImageBitmapRenderingContext {
  readonly attribute (HTMLCanvasElement or OffscreenCanvas) canvas;
  undefined transferFromImageBitmap(ImageBitmap? bitmap);
};

dictionary ImageBitmapRenderingContextSettings {
  boolean alpha = true;
};

typedef (HTMLImageElement or
         SVGImageElement) HTMLOrSVGImageElement;

typedef (HTMLOrSVGImageElement or
         HTMLVideoElement or
         HTMLCanvasElement or
         ImageBitmap or
         OffscreenCanvas) CanvasImageSource;

enum CanvasFillRule { "nonzero", "evenodd" };

dictionary CanvasRenderingContext2DSettings {
  boolean alpha = true;
  boolean desynchronized = false;
};

enum ImageSmoothingQuality { "low", "medium", "high" };

[Exposed=Window]
interface CanvasRenderingContext2D {
  // back-reference to the canvas
  readonly attribute HTMLCanvasElement canvas;

  CanvasRenderingContext2DSettings getContextAttributes();
};
CanvasRenderingContext2D includes CanvasState;
CanvasRenderingContext2D includes CanvasTransform;
CanvasRenderingContext2D includes CanvasCompositing;
CanvasRenderingContext2D includes CanvasImageSmoothing;
CanvasRenderingContext2D includes CanvasFillStrokeStyles;
CanvasRenderingContext2D includes CanvasShadowStyles;
CanvasRenderingContext2D includes CanvasFilters;
CanvasRenderingContext2D includes CanvasRect;
CanvasRenderingContext2D includes CanvasDrawPath;
CanvasRenderingContext2D includes CanvasUserInterface;
CanvasRenderingContext2D includes CanvasText;
CanvasRenderingContext2D includes CanvasDrawImage;
CanvasRenderingContext2D includes CanvasImageData;
CanvasRenderingContext2D includes CanvasPathDrawingStyles;
CanvasRenderingContext2D includes CanvasTextDrawingStyles;
CanvasRenderingContext2D includes CanvasPath;

interface mixin CanvasState {
  // state
  undefined save(); // push state on state stack
  undefined restore(); // pop state stack and restore state
};

interface mixin CanvasTransform {
  // transformations (default transform is the identity matrix)
  undefined scale(unrestricted double x, unrestricted double y);
  undefined rotate(unrestricted double angle);
  undefined translate(unrestricted double x, unrestricted double y);
  undefined transform(unrestricted double a, unrestricted double b, unrestricted double c, unrestricted double d, unrestricted double e, unrestricted double f);

  [NewObject] DOMMatrix getTransform();
  undefined setTransform(unrestricted double a, unrestricted double b, unrestricted double c, unrestricted double d, unrestricted double e, unrestricted double f);
  undefined setTransform(optional DOMMatrix2DInit transform = {});
  undefined resetTransform();

};

interface mixin CanvasCompositing {
  // compositing
  attribute unrestricted double globalAlpha; // (default 1.0)
  attribute DOMString globalCompositeOperation; // (default source-over)
};

interface mixin CanvasImageSmoothing {
  // image smoothing
  attribute boolean imageSmoothingEnabled; // (default true)
  attribute ImageSmoothingQuality imageSmoothingQuality; // (default low)

};

interface mixin CanvasFillStrokeStyles {
  // colors and styles (see also the CanvasPathDrawingStyles and CanvasTextDrawingStyles interfaces)
  attribute (DOMString or CanvasGradient or CanvasPattern) strokeStyle; // (default black)
  attribute (DOMString or CanvasGradient or CanvasPattern) fillStyle; // (default black)
  CanvasGradient createLinearGradient(double x0, double y0, double x1, double y1);
  CanvasGradient createRadialGradient(double x0, double y0, double r0, double x1, double y1, double r1);
  CanvasPattern? createPattern(CanvasImageSource image, [LegacyNullToEmptyString] DOMString repetition);

};

interface mixin CanvasShadowStyles {
  // shadows
  attribute unrestricted double shadowOffsetX; // (default 0)
  attribute unrestricted double shadowOffsetY; // (default 0)
  attribute unrestricted double shadowBlur; // (default 0)
  attribute DOMString shadowColor; // (default transparent black)
};

interface mixin CanvasFilters {
  // filters
  attribute DOMString filter; // (default "none")
};

interface mixin CanvasRect {
  // rects
  undefined clearRect(unrestricted double x, unrestricted double y, unrestricted double w, unrestricted double h);
  undefined fillRect(unrestricted double x, unrestricted double y, unrestricted double w, unrestricted double h);
  undefined strokeRect(unrestricted double x, unrestricted double y, unrestricted double w, unrestricted double h);
};

interface mixin CanvasDrawPath {
  // path API (see also CanvasPath)
  undefined beginPath();
  undefined fill(optional CanvasFillRule fillRule = "nonzero");
  undefined fill(Path2D path, optional CanvasFillRule fillRule = "nonzero");
  undefined stroke();
  undefined stroke(Path2D path);
  undefined clip(optional CanvasFillRule fillRule = "nonzero");
  undefined clip(Path2D path, optional CanvasFillRule fillRule = "nonzero");
  boolean isPointInPath(unrestricted double x, unrestricted double y, optional CanvasFillRule fillRule = "nonzero");
  boolean isPointInPath(Path2D path, unrestricted double x, unrestricted double y, optional CanvasFillRule fillRule = "nonzero");
  boolean isPointInStroke(unrestricted double x, unrestricted double y);
  boolean isPointInStroke(Path2D path, unrestricted double x, unrestricted double y);
};

interface mixin CanvasUserInterface {
  undefined drawFocusIfNeeded(Element element);
  undefined drawFocusIfNeeded(Path2D path, Element element);
  undefined scrollPathIntoView();
  undefined scrollPathIntoView(Path2D path);
};

interface mixin CanvasText {
  // text (see also the CanvasPathDrawingStyles and CanvasTextDrawingStyles interfaces)
  undefined fillText(DOMString text, unrestricted double x, unrestricted double y, optional unrestricted double maxWidth);
  undefined strokeText(DOMString text, unrestricted double x, unrestricted double y, optional unrestricted double maxWidth);
  TextMetrics measureText(DOMString text);
};

interface mixin CanvasDrawImage {
  // drawing images
  undefined drawImage(CanvasImageSource image, unrestricted double dx, unrestricted double dy);
  undefined drawImage(CanvasImageSource image, unrestricted double dx, unrestricted double dy, unrestricted double dw, unrestricted double dh);
  undefined drawImage(CanvasImageSource image, unrestricted double sx, unrestricted double sy, unrestricted double sw, unrestricted double sh, unrestricted double dx, unrestricted double dy, unrestricted double dw, unrestricted double dh);
};

interface mixin CanvasImageData {
  // pixel manipulation
  ImageData createImageData([EnforceRange] long sw, [EnforceRange] long sh);
  ImageData createImageData(ImageData imagedata);
  ImageData getImageData([EnforceRange] long sx, [EnforceRange] long sy, [EnforceRange] long sw, [EnforceRange] long sh);
  undefined putImageData(ImageData imagedata, [EnforceRange] long dx, [EnforceRange] long dy);
  undefined putImageData(ImageData imagedata, [EnforceRange] long dx, [EnforceRange] long dy, [EnforceRange] long dirtyX, [EnforceRange] long dirtyY, [EnforceRange] long dirtyWidth, [EnforceRange] long dirtyHeight);
};

enum CanvasLineCap { "butt", "round", "square" };
enum CanvasLineJoin { "round", "bevel", "miter" };
enum CanvasTextAlign { "start", "end", "left", "right", "center" };
enum CanvasTextBaseline { "top", "hanging", "middle", "alphabetic", "ideographic", "bottom" };
enum CanvasDirection { "ltr", "rtl", "inherit" };

interface mixin CanvasPathDrawingStyles {
  // line caps/joins
  attribute unrestricted double lineWidth; // (default 1)
  attribute CanvasLineCap lineCap; // (default "butt")
  attribute CanvasLineJoin lineJoin; // (default "miter")
  attribute unrestricted double miterLimit; // (default 10)

  // dashed lines
  undefined setLineDash(sequence<unrestricted double> segments); // default empty
  sequence<unrestricted double> getLineDash();
  attribute unrestricted double lineDashOffset;
};

interface mixin CanvasTextDrawingStyles {
  // text
  attribute DOMString font; // (default 10px sans-serif)
  attribute CanvasTextAlign textAlign; // (default: "start")
  attribute CanvasTextBaseline textBaseline; // (default: "alphabetic")
  attribute CanvasDirection direction; // (default: "inherit")
};

interface mixin CanvasPath {
  // shared path API methods
  undefined closePath();
  undefined moveTo(unrestricted double x, unrestricted double y);
  undefined lineTo(unrestricted double x, unrestricted double y);
  undefined quadraticCurveTo(unrestricted double cpx, unrestricted double cpy, unrestricted double x, unrestricted double y);
  undefined bezierCurveTo(unrestricted double cp1x, unrestricted double cp1y, unrestricted double cp2x, unrestricted double cp2y, unrestricted double x, unrestricted double y);
  undefined arcTo(unrestricted double x1, unrestricted double y1, unrestricted double x2, unrestricted double y2, unrestricted double radius);
  undefined rect(unrestricted double x, unrestricted double y, unrestricted double w, unrestricted double h);
  undefined arc(unrestricted double x, unrestricted double y, unrestricted double radius, unrestricted double startAngle, unrestricted double endAngle, optional boolean counterclockwise = false);
  undefined ellipse(unrestricted double x, unrestricted double y, unrestricted double radiusX, unrestricted double radiusY, unrestricted double rotation, unrestricted double startAngle, unrestricted double endAngle, optional boolean counterclockwise = false);
};

[Exposed=(Window,Worker)]
interface CanvasGradient {
  // opaque object
  undefined addColorStop(double offset, DOMString color);
};

[Exposed=(Window,Worker)]
interface CanvasPattern {
  // opaque object
  undefined setTransform(optional DOMMatrix2DInit transform = {});
};

[Exposed=(Window,Worker)]
interface TextMetrics {
  // x-direction
  readonly attribute double width; // advance width
  readonly attribute double actualBoundingBoxLeft;
  readonly attribute double actualBoundingBoxRight;

  // y-direction
  readonly attribute double fontBoundingBoxAscent;
  readonly attribute double fontBoundingBoxDescent;
  readonly attribute double actualBoundingBoxAscent;
  readonly attribute double actualBoundingBoxDescent;
  readonly attribute double emHeightAscent;
  readonly attribute double emHeightDescent;
  readonly attribute double hangingBaseline;
  readonly attribute double alphabeticBaseline;
  readonly attribute double ideographicBaseline;
};

[Exposed=(Window,Worker),
 Serializable]
interface ImageData {
  constructor(unsigned long sw, unsigned long sh);
  constructor(Uint8ClampedArray data, unsigned long sw, optional unsigned long sh);

  readonly attribute unsigned long width;
  readonly attribute unsigned long height;
  readonly attribute Uint8ClampedArray data;
};

[Exposed=(Window,Worker)]
interface Path2D {
  constructor(optional (Path2D or DOMString) path);

  undefined addPath(Path2D path, optional DOMMatrix2DInit transform = {});
};
Path2D includes CanvasPath;

[Exposed=Window]
interface Location { // but see also additional creation steps and overridden internal methods
  [LegacyUnforgeable] stringifier attribute USVString href;
  [LegacyUnforgeable] readonly attribute USVString origin;
  [LegacyUnforgeable] attribute USVString protocol;
  [LegacyUnforgeable] attribute USVString host;
  [LegacyUnforgeable] attribute USVString hostname;
  [LegacyUnforgeable] attribute USVString port;
  [LegacyUnforgeable] attribute USVString pathname;
  [LegacyUnforgeable] attribute USVString search;
  [LegacyUnforgeable] attribute USVString hash;

  [LegacyUnforgeable] undefined assign(USVString url);
  [LegacyUnforgeable] undefined replace(USVString url);
  [LegacyUnforgeable] undefined reload();

  [LegacyUnforgeable, SameObject] readonly attribute DOMStringList ancestorOrigins;
};

[Exposed=Window]
interface MediaError {
  const unsigned short MEDIA_ERR_ABORTED = 1;
  const unsigned short MEDIA_ERR_NETWORK = 2;
  const unsigned short MEDIA_ERR_DECODE = 3;
  const unsigned short MEDIA_ERR_SRC_NOT_SUPPORTED = 4;

  readonly attribute unsigned short code;
  readonly attribute DOMString message;
};

[Exposed=(Window,Worker)]
interface MessageChannel {
  constructor();

  readonly attribute MessagePort port1;
  readonly attribute MessagePort port2;
};

[Exposed=(Window,Worker,AudioWorklet)]
interface MessageEvent : Event {
  constructor(DOMString type, optional MessageEventInit eventInitDict = {});

  readonly attribute any data;
  readonly attribute USVString origin;
  readonly attribute DOMString lastEventId;
  readonly attribute MessageEventSource? source;
  readonly attribute FrozenArray<MessagePort> ports;

  undefined initMessageEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false, optional any data = null, optional USVString origin = "", optional DOMString lastEventId = "", optional MessageEventSource? source = null, optional sequence<MessagePort> ports = []);
};

dictionary MessageEventInit : EventInit {
  any data = null;
  USVString origin = "";
  DOMString lastEventId = "";
  MessageEventSource? source = null;
  sequence<MessagePort> ports = [];
};

typedef (WindowProxy or MessagePort or ServiceWorker) MessageEventSource;

[Exposed=(Window,Worker,AudioWorklet), Transferable]
interface MessagePort : EventTarget {
  undefined postMessage(any message, sequence<object> transfer);
  undefined postMessage(any message, optional PostMessageOptions options = {});
  undefined start();
  undefined close();

  // event handlers
  attribute EventHandler onmessage;
  attribute EventHandler onmessageerror;
};

dictionary PostMessageOptions {
  sequence<object> transfer = [];
};

interface mixin NavigatorPlugins {
  [SameObject] readonly attribute PluginArray plugins;
  [SameObject] readonly attribute MimeTypeArray mimeTypes;
  boolean javaEnabled();
};

[Exposed=Window]
interface PluginArray {
  undefined refresh();
  readonly attribute unsigned long length;
  getter object? item(unsigned long index);
  object? namedItem(DOMString name);
};

[Exposed=Window]
interface MimeTypeArray {
  readonly attribute unsigned long length;
  getter object? item(unsigned long index);
  object? namedItem(DOMString name);
};

[Exposed=Window]
interface MimeType {
  readonly attribute undefined type;
  readonly attribute undefined description;
  readonly attribute undefined suffixes;
  readonly attribute undefined enabledPlugin;
};

[Exposed=Window]
interface Navigator {
  // objects implementing this interface also implement the interfaces given below
};
Navigator includes NavigatorID;
Navigator includes NavigatorLanguage;
Navigator includes NavigatorOnLine;
Navigator includes NavigatorContentUtils;
Navigator includes NavigatorCookies;
Navigator includes NavigatorPlugins;
Navigator includes NavigatorConcurrentHardware;

interface mixin NavigatorID {
  readonly attribute DOMString appCodeName; // constant "Mozilla"
  readonly attribute DOMString appName; // constant "Netscape"
  readonly attribute DOMString appVersion;
  readonly attribute DOMString platform;
  readonly attribute DOMString product; // constant "Gecko"
  [Exposed=Window] readonly attribute DOMString productSub;
  readonly attribute DOMString userAgent;
  [Exposed=Window] readonly attribute DOMString vendor;
  [Exposed=Window] readonly attribute DOMString vendorSub; // constant ""
};

interface mixin NavigatorLanguage {
  readonly attribute DOMString language;
  readonly attribute FrozenArray<DOMString> languages;
};

interface mixin NavigatorOnLine {
  readonly attribute boolean onLine;
};

interface mixin NavigatorContentUtils {
  [SecureContext] undefined registerProtocolHandler(DOMString scheme, USVString url);
  [SecureContext] undefined unregisterProtocolHandler(DOMString scheme, USVString url);
};

interface mixin NavigatorCookies {
  readonly attribute boolean cookieEnabled;
};

interface mixin NavigatorConcurrentHardware {
  readonly attribute unsigned long long hardwareConcurrency;
};

typedef (OffscreenCanvasRenderingContext2D or ImageBitmapRenderingContext or WebGLRenderingContext or WebGL2RenderingContext) OffscreenRenderingContext;

dictionary ImageEncodeOptions {
  DOMString type = "image/png";
  unrestricted double quality;
};

enum OffscreenRenderingContextId { "2d", "bitmaprenderer", "webgl", "webgl2" };

[Exposed=(Window,Worker), Transferable]
interface OffscreenCanvas : EventTarget {
  constructor([EnforceRange] unsigned long long width, [EnforceRange] unsigned long long height);

  attribute [EnforceRange] unsigned long long width;
  attribute [EnforceRange] unsigned long long height;

  OffscreenRenderingContext? getContext(OffscreenRenderingContextId contextId, optional any options = null);
  ImageBitmap transferToImageBitmap();
  Promise<Blob> convertToBlob(optional ImageEncodeOptions options = {});
};

[Exposed=(Window,Worker)]
interface OffscreenCanvasRenderingContext2D {
  undefined commit();
  readonly attribute OffscreenCanvas canvas;
};

OffscreenCanvasRenderingContext2D includes CanvasState;
OffscreenCanvasRenderingContext2D includes CanvasTransform;
OffscreenCanvasRenderingContext2D includes CanvasCompositing;
OffscreenCanvasRenderingContext2D includes CanvasImageSmoothing;
OffscreenCanvasRenderingContext2D includes CanvasFillStrokeStyles;
OffscreenCanvasRenderingContext2D includes CanvasShadowStyles;
OffscreenCanvasRenderingContext2D includes CanvasFilters;
OffscreenCanvasRenderingContext2D includes CanvasRect;
OffscreenCanvasRenderingContext2D includes CanvasDrawPath;
OffscreenCanvasRenderingContext2D includes CanvasText;
OffscreenCanvasRenderingContext2D includes CanvasDrawImage;
OffscreenCanvasRenderingContext2D includes CanvasImageData;
OffscreenCanvasRenderingContext2D includes CanvasPathDrawingStyles;
OffscreenCanvasRenderingContext2D includes CanvasTextDrawingStyles;
OffscreenCanvasRenderingContext2D includes CanvasPath;

[Exposed=Window]
interface PageTransitionEvent : Event {
  constructor(DOMString type, optional PageTransitionEventInit eventInitDict = {});

  readonly attribute boolean persisted;
};

dictionary PageTransitionEventInit : EventInit {
  boolean persisted = false;
};

[Exposed=Window]
interface PopStateEvent : Event {
  constructor(DOMString type, optional PopStateEventInit eventInitDict = {});

  readonly attribute any state;
};

dictionary PopStateEventInit : EventInit {
  any state = null;
};

[Exposed=(Window,Worker)]
interface PromiseRejectionEvent : Event {
  constructor(DOMString type, PromiseRejectionEventInit eventInitDict);

  readonly attribute Promise<any> promise;
  readonly attribute any reason;
};

dictionary PromiseRejectionEventInit : EventInit {
  required Promise<any> promise;
  any reason;
};

interface mixin AbstractWorker {
  attribute EventHandler onerror;
};

[Exposed=Window]
interface SharedWorker : EventTarget {
  constructor(USVString scriptURL, optional (DOMString or WorkerOptions) options = {});

  readonly attribute MessagePort port;
};
SharedWorker includes AbstractWorker;

[Global=(Worker,SharedWorker),Exposed=SharedWorker]
interface SharedWorkerGlobalScope : WorkerGlobalScope {
  [Replaceable] readonly attribute DOMString name;

  undefined close();

  attribute EventHandler onconnect;
};

[Exposed=Window]
interface Storage {
  readonly attribute unsigned long length;
  DOMString? key(unsigned long index);
  getter DOMString? getItem(DOMString key);
  setter undefined setItem(DOMString key, DOMString value);
  deleter undefined removeItem(DOMString key);
  undefined clear();
};

[Exposed=Window]
interface StorageEvent : Event {
  constructor(DOMString type, optional StorageEventInit eventInitDict = {});

  readonly attribute DOMString? key;
  readonly attribute DOMString? oldValue;
  readonly attribute DOMString? newValue;
  readonly attribute USVString url;
  readonly attribute Storage? storageArea;

  undefined initStorageEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false, optional DOMString? key = null, optional DOMString? oldValue = null, optional DOMString? newValue = null, optional USVString url = "", optional Storage? storageArea = null);
};

dictionary StorageEventInit : EventInit {
  DOMString? key = null;
  DOMString? oldValue = null;
  DOMString? newValue = null;
  USVString url = "";
  Storage? storageArea = null;
};

[Exposed=Window]
interface SubmitEvent : Event {
  constructor(DOMString type, optional SubmitEventInit eventInitDict = {});

  readonly attribute HTMLElement? submitter;
};

dictionary SubmitEventInit : EventInit {
  HTMLElement? submitter = null;
};

enum TextTrackMode { "disabled",  "hidden",  "showing" };
enum TextTrackKind { "subtitles",  "captions",  "descriptions",  "chapters",  "metadata" };

[Exposed=Window]
interface TextTrack : EventTarget {
  readonly attribute TextTrackKind kind;
  readonly attribute DOMString label;
  readonly attribute DOMString language;

  readonly attribute DOMString id;
  readonly attribute DOMString inBandMetadataTrackDispatchType;

  attribute TextTrackMode mode;

  readonly attribute TextTrackCueList? cues;
  readonly attribute TextTrackCueList? activeCues;

  undefined addCue(TextTrackCue cue);
  undefined removeCue(TextTrackCue cue);

  attribute EventHandler oncuechange;
};

[Exposed=Window]
interface TextTrackCue : EventTarget {
  readonly attribute TextTrack? track;

  attribute DOMString id;
  attribute double startTime;
  attribute double endTime;
  attribute boolean pauseOnExit;

  attribute EventHandler onenter;
  attribute EventHandler onexit;
};

[Exposed=Window]
interface TextTrackCueList {
  readonly attribute unsigned long length;
  getter TextTrackCue (unsigned long index);
  TextTrackCue? getCueById(DOMString id);
};

[Exposed=Window]
interface TextTrackList : EventTarget {
  readonly attribute unsigned long length;
  getter TextTrack (unsigned long index);
  TextTrack? getTrackById(DOMString id);

  attribute EventHandler onchange;
  attribute EventHandler onaddtrack;
  attribute EventHandler onremovetrack;
};

[Exposed=Window]
interface TimeRanges {
  readonly attribute unsigned long length;
  double start(unsigned long index);
  double end(unsigned long index);
};

[Exposed=Window]
interface TrackEvent : Event {
  constructor(DOMString type, optional TrackEventInit eventInitDict = {});

  readonly attribute (VideoTrack or AudioTrack or TextTrack)? track;
};

dictionary TrackEventInit : EventInit {
  (VideoTrack or AudioTrack or TextTrack)? track = null;
};

[Exposed=Window]
interface ValidityState {
  readonly attribute boolean valueMissing;
  readonly attribute boolean typeMismatch;
  readonly attribute boolean patternMismatch;
  readonly attribute boolean tooLong;
  readonly attribute boolean tooShort;
  readonly attribute boolean rangeUnderflow;
  readonly attribute boolean rangeOverflow;
  readonly attribute boolean stepMismatch;
  readonly attribute boolean badInput;
  readonly attribute boolean customError;
  readonly attribute boolean valid;
};

[Exposed=Window]
interface VideoTrackList : EventTarget {
  readonly attribute unsigned long length;
  getter VideoTrack (unsigned long index);
  VideoTrack? getTrackById(DOMString id);
  readonly attribute long selectedIndex;

  attribute EventHandler onchange;
  attribute EventHandler onaddtrack;
  attribute EventHandler onremovetrack;
};

[Exposed=Window]
interface VideoTrack {
  readonly attribute DOMString id;
  readonly attribute DOMString kind;
  readonly attribute DOMString label;
  readonly attribute DOMString language;
  attribute boolean selected;
};

enum BinaryType { "blob", "arraybuffer" };
[Exposed=(Window,Worker)]
interface WebSocket : EventTarget {
  constructor(USVString url, optional (DOMString or sequence<DOMString>) protocols = []);

  readonly attribute USVString url;

  // ready state
  const unsigned short CONNECTING = 0;
  const unsigned short OPEN = 1;
  const unsigned short CLOSING = 2;
  const unsigned short CLOSED = 3;
  readonly attribute unsigned short readyState;
  readonly attribute unsigned long long bufferedAmount;

  // networking
  attribute EventHandler onopen;
  attribute EventHandler onerror;
  attribute EventHandler onclose;
  readonly attribute DOMString extensions;
  readonly attribute DOMString protocol;
  undefined close(optional [Clamp] unsigned short code, optional USVString reason);

  // messaging
  attribute EventHandler onmessage;
  attribute BinaryType binaryType;
  undefined send(USVString data);
  undefined send(Blob data);
  undefined send(ArrayBuffer data);
  undefined send(ArrayBufferView data);
};

[Global=Window,
 Exposed=Window,
 LegacyUnenumerableNamedProperties]
interface Window : EventTarget {
  // the current browsing context
  [LegacyUnforgeable] readonly attribute WindowProxy window;
  [Replaceable] readonly attribute WindowProxy self;
  [LegacyUnforgeable] readonly attribute Document document;
  attribute DOMString name;
  [PutForwards=href, LegacyUnforgeable] readonly attribute Location location;
  readonly attribute History history;
  readonly attribute CustomElementRegistry customElements;
  [Replaceable] readonly attribute BarProp locationbar;
  [Replaceable] readonly attribute BarProp menubar;
  [Replaceable] readonly attribute BarProp personalbar;
  [Replaceable] readonly attribute BarProp scrollbars;
  [Replaceable] readonly attribute BarProp statusbar;
  [Replaceable] readonly attribute BarProp toolbar;
  attribute DOMString status;
  undefined close();
  readonly attribute boolean closed;
  undefined stop();
  undefined focus();
  undefined blur();

  // other browsing contexts
  [Replaceable] readonly attribute WindowProxy frames;
  [Replaceable] readonly attribute unsigned long length;
  [LegacyUnforgeable] readonly attribute WindowProxy? top;
  attribute any opener;
  [Replaceable] readonly attribute WindowProxy? parent;
  readonly attribute Element? frameElement;
  WindowProxy? open(optional USVString url = "", optional DOMString target = "_blank", optional [LegacyNullToEmptyString] DOMString features = "");
  getter object (DOMString name);
  // Since this is the global object, the IDL named getter adds a NamedPropertiesObject exotic
  // object on the prototype chain. Indeed, this does not make the global object an exotic object.
  // Indexed access is taken care of by the WindowProxy exotic object.

  // the user agent
  readonly attribute Navigator navigator;
  readonly attribute boolean originAgentCluster;

  // user prompts
  undefined alert();
  undefined alert(DOMString message);
  boolean confirm(optional DOMString message = "");
  DOMString? prompt(optional DOMString message = "", optional DOMString default = "");
  undefined print();

  undefined postMessage(any message, USVString targetOrigin, optional sequence<object> transfer = []);
  undefined postMessage(any message, optional WindowPostMessageOptions options = {});

  // also has obsolete members
};
Window includes GlobalEventHandlers;
Window includes WindowEventHandlers;

interface mixin WindowLocalStorage {
  readonly attribute Storage localStorage;
};
Window includes WindowLocalStorage;

dictionary WindowPostMessageOptions : PostMessageOptions {
  USVString targetOrigin = "/";
};

partial interface Window {
  undefined captureEvents();
  undefined releaseEvents();

  [Replaceable, SameObject] readonly attribute External external;
};

[Exposed=(Window,DedicatedWorker,SharedWorker)]
interface Worker : EventTarget {
  constructor(USVString scriptURL, optional WorkerOptions options = {});

  undefined terminate();

  undefined postMessage(any message, sequence<object> transfer);
  undefined postMessage(any message, optional PostMessageOptions options = {});
  attribute EventHandler onmessage;
  attribute EventHandler onmessageerror;
};

dictionary WorkerOptions {
  WorkerType type = "classic";
  RequestCredentials credentials = "same-origin"; // credentials is only used if type is "module"
  DOMString name = "";
};

enum WorkerType { "classic", "module" };

Worker includes AbstractWorker;

[Exposed=Worker]
interface WorkerGlobalScope : EventTarget {
  readonly attribute WorkerGlobalScope self;
  readonly attribute WorkerLocation location;
  readonly attribute WorkerNavigator navigator;
  undefined importScripts(USVString... urls);

  attribute OnErrorEventHandler onerror;
  attribute EventHandler onlanguagechange;
  attribute EventHandler onoffline;
  attribute EventHandler ononline;
  attribute EventHandler onrejectionhandled;
  attribute EventHandler onunhandledrejection;
};

[Exposed=Worker]
interface WorkerLocation {
  stringifier readonly attribute USVString href;
  readonly attribute USVString origin;
  readonly attribute USVString protocol;
  readonly attribute USVString host;
  readonly attribute USVString hostname;
  readonly attribute USVString port;
  readonly attribute USVString pathname;
  readonly attribute USVString search;
  readonly attribute USVString hash;
};

[Exposed=Window, SecureContext]
interface Worklet {
  [NewObject] Promise<undefined> addModule(USVString moduleURL, optional WorkletOptions options = {});
};

dictionary WorkletOptions {
  RequestCredentials credentials = "same-origin";
};

[Exposed=Worklet, SecureContext]
interface WorkletGlobalScope {};

interface mixin HTMLHyperlinkElementUtils {
  [CEReactions] stringifier attribute USVString href;
  readonly attribute USVString origin;
  [CEReactions] attribute USVString protocol;
  [CEReactions] attribute USVString username;
  [CEReactions] attribute USVString password;
  [CEReactions] attribute USVString host;
  [CEReactions] attribute USVString hostname;
  [CEReactions] attribute USVString port;
  [CEReactions] attribute USVString pathname;
  [CEReactions] attribute USVString search;
  [CEReactions] attribute USVString hash;
};

interface mixin HTMLOrSVGElement {
  [SameObject] readonly attribute DOMStringMap dataset;
  attribute DOMString nonce; // intentionally no [CEReactions]

  [CEReactions] attribute boolean autofocus;
  [CEReactions] attribute long tabIndex;
  undefined focus(optional FocusOptions options = {});
  undefined blur();
};

interface mixin ElementContentEditable {
  [CEReactions] attribute DOMString contentEditable;
  [CEReactions] attribute DOMString enterKeyHint;
  readonly attribute boolean isContentEditable;
  [CEReactions] attribute DOMString inputMode;
};

interface mixin ARIAMixin {
	attribute DOMString? role;


	attribute DOMString ariaAtomic;
	attribute DOMString ariaAutoComplete;
	attribute DOMString ariaBusy;
	attribute DOMString ariaChecked;
	attribute DOMString ariaColCount;
	attribute DOMString ariaColIndex;
	attribute DOMString ariaColIndexText;
	attribute DOMString ariaColSpan;

	attribute DOMString ariaCurrent;

	attribute DOMString ariaDescription;

	attribute DOMString ariaDisabled;

	attribute DOMString ariaExpanded;

	attribute DOMString ariaHasPopup;
	attribute DOMString ariaHidden;
	attribute DOMString ariaInvalid;
	attribute DOMString ariaKeyShortcuts;
	attribute DOMString ariaLabel;

	attribute DOMString ariaLevel;
	attribute DOMString ariaLive;
	attribute DOMString ariaModal;
	attribute DOMString ariaMultiLine;
	attribute DOMString ariaMultiSelectable;
	attribute DOMString ariaOrientation;

	attribute DOMString ariaPlaceholder;
	attribute DOMString ariaPosInSet;
	attribute DOMString ariaPressed;
	attribute DOMString ariaReadOnly;

	attribute DOMString ariaRequired;
	attribute DOMString ariaRoleDescription;
	attribute DOMString ariaRowCount;
	attribute DOMString ariaRowIndex;
	attribute DOMString ariaRowIndexText;
	attribute DOMString ariaRowSpan;
	attribute DOMString ariaSelected;
	attribute DOMString ariaSetSize;
	attribute DOMString ariaSort;
	attribute DOMString ariaValueMax;
	attribute DOMString ariaValueMin;
	attribute DOMString ariaValueNow;
	attribute DOMString ariaValueText;
};

dictionary FocusOptions {
  boolean preventScroll = false;
};

[LegacyTreatNonObjectAsNull]
callback OnErrorEventHandlerNonNull = any ((Event or DOMString) event, optional DOMString source, optional unsigned long lineno, optional unsigned long colno, optional any error);
typedef OnErrorEventHandlerNonNull? OnErrorEventHandler;

[LegacyTreatNonObjectAsNull]
callback OnBeforeUnloadEventHandlerNonNull = DOMString? (Event event);
typedef OnBeforeUnloadEventHandlerNonNull? OnBeforeUnloadEventHandler;

[Exposed=Worker]
interface WorkerNavigator {};
WorkerNavigator includes NavigatorID;
WorkerNavigator includes NavigatorLanguage;
WorkerNavigator includes NavigatorOnLine;
WorkerNavigator includes NavigatorConcurrentHardware;

enum SelectionMode {
  "select",
  "start",
  "end",
  "preserve" // default
};

[LegacyTreatNonObjectAsNull]
callback EventHandlerNonNull = any (Event event);
typedef EventHandlerNonNull? EventHandler;

// The part below was added manually
// inspired by https://w3c.github.io/uievents/#event-types-list

callback InputEventHandler = undefined (InputEvent event);
callback FocusEventHandler = undefined (FocusEvent event);
callback MouseEventHandler = undefined (MouseEvent event);
callback CompositionEventHandler = undefined (CompositionEvent event);
callback KeyboardEventHandler = undefined (KeyboardEvent event);
callback UIEventHandler = undefined (UIEvent event);
callback WheelEventHandler = undefined (WheelEvent event);

interface mixin GlobalEventHandlers {
  attribute UIEventHandler? onabort;
  attribute MouseEventHandler? onauxclick;
  attribute FocusEventHandler? onblur;
  attribute EventHandler oncancel;
  attribute EventHandler oncanplay;
  attribute EventHandler oncanplaythrough;
  attribute EventHandler onchange;
  attribute MouseEventHandler? onclick;
  attribute EventHandler onclose;
  attribute EventHandler oncontextmenu;
  attribute EventHandler oncuechange;
  attribute MouseEventHandler? ondblclick;
  attribute EventHandler ondrag;
  attribute EventHandler ondragend;
  attribute EventHandler ondragenter;
  attribute EventHandler ondragleave;
  attribute EventHandler ondragover;
  attribute EventHandler ondragstart;
  attribute EventHandler ondrop;
  attribute EventHandler ondurationchange;
  attribute EventHandler onemptied;
  attribute EventHandler onended;
  attribute OnErrorEventHandler onerror;
  attribute FocusEventHandler? onfocus;
  attribute EventHandler onformdata;
  attribute InputEventHandler? oninput;
  attribute EventHandler oninvalid;
  attribute KeyboardEventHandler? onkeydown;
  attribute EventHandler onkeypress;
  attribute KeyboardEventHandler? onkeyup;
  attribute UIEventHandler? onload;
  attribute EventHandler onloadeddata;
  attribute EventHandler onloadedmetadata;
  attribute EventHandler onloadstart;
  attribute MouseEventHandler? onmousedown;
  [LegacyLenientThis] attribute MouseEventHandler? onmouseenter;
  [LegacyLenientThis] attribute MouseEventHandler? onmouseleave;
  attribute MouseEventHandler? onmousemove;
  attribute MouseEventHandler? onmouseout;
  attribute MouseEventHandler? onmouseover;
  attribute MouseEventHandler? onmouseup;
  attribute EventHandler onpause;
  attribute EventHandler onplay;
  attribute EventHandler onplaying;
  attribute EventHandler onprogress;
  attribute EventHandler onratechange;
  attribute EventHandler onreset;
  attribute EventHandler onresize;
  attribute EventHandler onscroll;
  attribute EventHandler onsecuritypolicyviolation;
  attribute EventHandler onseeked;
  attribute EventHandler onseeking;
  attribute UIEventHandler? onselect;
  attribute EventHandler onslotchange;
  attribute EventHandler onstalled;
  attribute EventHandler onsubmit;
  attribute EventHandler onsuspend;
  attribute EventHandler ontimeupdate;
  attribute EventHandler ontoggle;
  attribute EventHandler onvolumechange;
  attribute EventHandler onwaiting;
  attribute EventHandler onwebkitanimationend;
  attribute EventHandler onwebkitanimationiteration;
  attribute EventHandler onwebkitanimationstart;
  attribute EventHandler onwebkittransitionend;
  attribute WheelEventHandler? onwheel;
};
