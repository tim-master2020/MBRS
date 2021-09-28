import React from 'react';
import ${class.name}Table from './${class.name}Table'
import Add${class.name} from './Add${class.name}'
import axios from 'axios';

class ${class.name}Page extends React.Component {

    constructor(props) {
        super(props);
        this.state =  {
        ${class.name?uncap_first}s: []
        }

        this.add${class.name} = this.add${class.name}.bind(this);
        this.handler = this.handler.bind(this);

        axios.get("http://localhost:8081/api/${class.name}").then(
            (resp) => this.onSuccessHandler(resp),
            (resp) => this.onErrorHandler(resp)
            );
    }

    add${class.name}(${class.name?uncap_first}) {
        this.setState(prevState => ({
        entities: [...prevState.${class.name?uncap_first}s, ${class.name?uncap_first}]
        }));
    }

    onSuccessHandler(resp) {
        var temp = [];

        for (var i = 0; i < resp.data.length; i++) {
            temp.push(resp.data[i]);
        }
        this.setState({
            ${class.name?uncap_first}s: temp
        });
    }

    onErrorHandler(response) {
        alert("Error response: Uncovered case");
    }

    handler() {
        window.loaction.reload();
    }

    render() {
        return (
        <div className="container">
            <h1 id="manage">Manage ${class.name?uncap_first}s</h1>
            <div className="row">
                <div className="add${class.name}Button">
                    <Add${class.name}/>
                </div>
                <div className="col-md-10-drcards">
                    <br />
                    <${class.name}Table content={this.state.${class.name?uncap_first}s} />
                </div>
            </div>
        </div>
        );
    }
}

export default ${class.name}Page;
