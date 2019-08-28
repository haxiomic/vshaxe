package vshaxe.view.cache;

import haxe.display.Server;

enum Kind {
	ServerRoot;
	MemoryRoot;
	ContextMemory(ctx:HaxeServerContext);
	ModuleMemory(sign:String, path:String);
	Context(ctx:HaxeServerContext);
	ContextModules(ctx:HaxeServerContext);
	ContextFiles(ctx:HaxeServerContext);
	ModuleInfo(sign:String, path:String);
	ModuleList(modules:Array<ModuleId>);
	StringList(strings:Array<String>);
	StringMapping(mapping:Array<{var key:String; var value:String;}>);
	Nodes(nodes:Array<Node>);
	Leaf;
}

class Node extends TreeItem {
	public final parent:Null<Node>;
	public final kind:Kind;

	public function new(label:String, description:Null<String>, kind:Kind, ?parent:Node) {
		super(label, kind == Leaf ? None : Collapsed);
		this.description = description;
		this.parent = parent;
		this.kind = kind;
		switch kind {
			case StringList(_) | StringMapping(_) | Context(_):
				this.contextValue = "copyable";
			case ServerRoot | MemoryRoot | ContextModules(_) | ContextFiles(_) | ModuleInfo(_) | ContextMemory(_) | ModuleMemory(_):
				this.contextValue = "reloadable";
			case _:
		}
	}
}
