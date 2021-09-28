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
        const item = ${class.name?uncap_first};
        axios.delete(`http://localhost:8081/api/${class.name}/${r"${item.id}"}`).then(
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
                    const ${property.name?uncap_first} = this.props.content[i].${property.name?uncap_first};
                </#if>
            </#list>
            <#list class.FMLinkedProperty as p>
                    const ${p.name?uncap_first} = this.props.content[i].${p.name?uncap_first};
            </#list>
                    const id = this.props.content[i].id;

            { ${class.name?uncap_first}s.push({
            <#list properties as property>
                <#if property.upper == 1>
                    ${property.name?uncap_first}: ${property.name?uncap_first},
                </#if>
            </#list>
            <#list class.FMLinkedProperty as p>
                 ${p.name?uncap_first} : this.props.content[i].${p.name?uncap_first},
            </#list>
                    id: id,
        }); }
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
                accessor: "id",
                Header: "Delete",
                Cell: ({ row }) => (<Button className="delete${class.name?cap_first}" variant="outline-danger" onClick={this.delete${class.name?cap_first}.bind(this, row)} >Delete</Button>)
            },
            {
                accessor: "id",
                Header: "Edit",
                Cell: ({ original }) => (<Edit${class.name?cap_first} content={original}/>)
            }
        ]

        return (
            <div>
                <ReactTable data={${class.name?uncap_first}s}
                            columns={${class.name?uncap_first}sColumn}
                            minRows={0}
                            showPagination={false} />
            </div>
        )
    }
}

export default ${class.name}Table
