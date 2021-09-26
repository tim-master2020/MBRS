import React from 'react'
import { Modal, Button, Card } from "react-bootstrap";
import axios from 'axios';
import Edit${class.name} from './Edit${class.name}';
import 'react-table-6/react-table.css';

var ReactTable = require('react-table-6').default;

class ${class.name}Table extends React.Component{
    constructor(props) {
        super(props);
    }

    delete${class.name}(${class.name?uncap_first}) {
        axios.delete("http://localhost:8081/api/${class.name}", ${class.name?uncap_first}).then(
            (resp) => this.onSuccessHandler(resp),
            (resp) => this.onErrorHandler(resp)
        );
    }

    onErrorHandler(resp) {
        console.log("error");
        alert("error");
    }

    onSuccessHandler(resp) {
        window.location.reload();
    }

    render() {
        const ${class.name?uncap_first}s = [];

        for (var i = 0; i < this.props.content.length; i++) {
            <#list properties as property>
                <#if property.upper == 1>
                    const ${property.name} = this.props.content[i].${property.name};
                </#if>
            </#list>

            { ${class.name?uncap_first}s.push({
            <#list properties as property>
                <#if property.upper == 1>
                    ${property.name}: ${property.name},
                </#if>
            </#list>}); }
        }

        const ${class.name?uncap_first}sColumn = [
            <#list properties as property>
                <#if property.upper == 1>
                    {
                    accessor: "${property.name?uncap_first}",
                    Header: "${property.name?cap_first}"
                    },
                </#if>
            </#list>
            {
                accessor: "name",
                Header: "Delete",
                Cell: ({ row }) => (<Button className="delete${class.name?cap_first}" variant="outline-danger" onClick={this.delete${class.name?cap_first}.bind(this, row)} >Delete</Button>)
            },
            {
                accessor: "name",
                Header: "Edit",
                Cell: ({ original }) => (<Edit${class.name?cap_first} content={original}/>)
            }
        ]

        return (
            <div>
                <ReactTable data={${class.name?uncap_first}sColumn}
                            minRows={0}
                            showPagination={false} />
            </div>
        )
    }
}

export default ${class.name}Table
