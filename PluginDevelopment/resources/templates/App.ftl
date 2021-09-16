import React from 'react';
import '../node_modules/bootstrap/dist/css/bootstrap.min.css';
import './App.css';
<#list classes as class>
    import ${class.name}Page from './${class.name}Page'
</#list>

export default class App extends React.Component {

    constructor(props) {
    super(props);

    this.state =  {
    }

    }

    render() {
        return (
            <div>
                <#list classes as class>
                    <${class.name}Page/>
                    <br/>
                </#list>
            </div>
            );
        }
}
