import json
import urllib.request
import os

URL = "http://localhost:8000/openapi.json"
JSON_OUTPUT = "api_docs/openapi.json"
MD_OUTPUT = "api_docs/API_DOCS.md"
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def fetch_openapi():
    print(f"Fetching {URL}...")
    try:
        response = urllib.request.urlopen(URL)
        data = json.loads(response.read().decode('utf-8'))
        
        json_path = os.path.join(BASE_DIR, JSON_OUTPUT)
        with open(json_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        print(f"Saved JSON to {json_path}")
        return data
    except Exception as e:
        print(f"Failed to fetch openapi.json: {e}")
        return None

def generate_markdown(data):
    if not data:
        return
    md_path = os.path.join(BASE_DIR, MD_OUTPUT)
    with open(md_path, 'w', encoding='utf-8') as f:
        title = data.get('info', {}).get('title', 'API Docs')
        version = data.get('info', {}).get('version', '1.0.0')
        desc = data.get('info', {}).get('description', '')
        
        f.write(f"# {title} (v{version})\n\n")
        if desc:
            f.write(f"{desc}\n\n")
            
        paths = data.get('paths', {})
        for path, methods in paths.items():
            for method, details in methods.items():
                if method.startswith('x-'):
                    continue
                
                f.write(f"## {method.upper()} {path}\n\n")
                summary = details.get('summary', '')
                if summary:
                    f.write(f"**Summary**: {summary}\n\n")
                
                description = details.get('description', '')
                if description:
                    f.write(f"{description}\n\n")
                    
                parameters = details.get('parameters', [])
                if parameters:
                    f.write("### Parameters\n")
                    f.write("| Name | In | Required | Type | Description |\n")
                    f.write("| --- | --- | --- | --- | --- |\n")
                    for param in parameters:
                        name = param.get('name', '')
                        in_ = param.get('in', '')
                        required = param.get('required', False)
                        schema = param.get('schema', {})
                        type_ = schema.get('type', '')
                        if not type_ and '$ref' in schema:
                            type_ = schema['$ref'].split('/')[-1]
                        desc = param.get('description', '').replace('\n', ' ')
                        f.write(f"| {name} | {in_} | {required} | {type_} | {desc} |\n")
                    f.write("\n")
                    
                request_body = details.get('requestBody', {})
                if request_body:
                    f.write("### Request Body\n")
                    content = request_body.get('content', {})
                    for content_type, schema_info in content.items():
                        schema = schema_info.get('schema', {})
                        ref = schema.get('$ref', '')
                        if ref:
                            model = ref.split('/')[-1]
                            f.write(f"- `{content_type}`: Reference `{model}`\n")
                        else:
                            f.write(f"- `{content_type}`: {schema.get('type', 'object')}\n")
                    f.write("\n")

        print(f"Generated Markdown Docs to {md_path}")

if __name__ == "__main__":
    data = fetch_openapi()
    generate_markdown(data)
