import React from 'react';
import { Modal, Button } from "react-bootstrap";
import Swal from 'sweetalert2';
import withReactContent from 'sweetalert2-react-content';
import axios from 'axios'

const TypeCreatedAlert = withReactContent(Swal)

class Add${class.name} extends React.Component {

    constructor(props) {
        super(props);

        this.handleShow = this.handleShow.bind(this);
        this.handleClose = this.handleClose.bind(this);
        this.handleChange = this.handleChange.bind(this);

        this.add${class.name} = this.add${class.name}.bind(this);

        this.state = {
            show: false,
        <#list properties as property>
            <#if property.upper == 1 && property.type == "String">
                ${property.name}: "",
            </#if>
            <#if property.upper == 1 && property.type == "Long">
                ${property.name}: 0,
            </#if>
        </#list>
        <#list class.FMLinkedProperty as linkedP>
            <#if linkedP.upper == 1>
                ${linkedP.name}: 0,
            <#else>
                ${linkedP.name?uncap_first}s: [],
                ${linkedP.name?uncap_first}name: "",
            </#if>
        </#list>
        };
    }

    componentDidMount() {
        <#list class.FMLinkedProperty as linkedP>
            <#if linkedP.upper == 1>
                axios.get('http://localhost:8081/api/${linkedP.name?uncap_first}/${linkedP.name?uncap_first}s', options).then(
                (resp) => this.onSuccessHandler${linkedP.name?cap_first}s(resp),
                (resp) => this.onErrorHandler${linkedP.name?cap_first}s(resp),
                );
            <#else>
                axios.get('http://localhost:8081/api/${linkedP.name?uncap_first}/${linkedP.name?uncap_first}s', options).then(
                    (resp) => this.onSuccessHandler${linkedP.name?cap_first}s(resp),
                    (resp) => this.onErrorHandler${linkedP.name?cap_first}s(resp),
                );
            </#if>
        </#list>
    }

    <#list class.FMLinkedProperty as linkedP>
        <#if linkedP.upper == 1>
            onSuccessHandler${linkedP.name?cap_first}(resp) {
                    this.setState({
                    ${linkedP.name?uncap_first}s: resp.data,
                    });
            }
            onErrorHandler${linkedP.name?cap_first}(response) {
                alert("Error response: Uncovered case");
            }
        <#else>
            onSuccessHandler${linkedP.name?cap_first}(resp) {
                    this.setState({
                    ${linkedP.name?uncap_first}s: resp.data,
                    });
            }
            onErrorHandler${linkedP.name?cap_first}(response) {
                alert("Error response: Uncovered case");
            }
        </#if>
    </#list>


    add${class.name}(event) {
        event.preventDefault();
        axios.post("http://localhost:8081/api/${class.name?uncap_first}/save", this.state).then(
            (resp) => this.onSuccessHandler(resp),
            (resp) => this.onErrorHandler(resp)
            );
    }

    onErrorHandler(resp) {
        TypeCreatedAlert.fire({
        title: "Error occured",
        text: '',
        type: "error",
        button: true
        });

    }

    onSuccessHandler(resp) {

        TypeCreatedAlert.fire({
        title: "${class.name} added successfully",
        text: "",
        type: "success",
        });

        this.setState({ redirect: this.state.redirect === false });
        window.location.reload();
        this.handleClose();
    }

    handleClose() {
        this.setState({ show: false });
    }

    handleShow() {
        this.setState({ show: true });
    }

    handleChange(e) {
        this.setState({...this.state, [e.target.name]: e.target.value});
    }

    handleSelectDoctor(eventKey, event) {
        event.preventDefault();

        this.setState({ doctor: this.state.doctors[eventKey] });
    }

    render() {
        return (
        <div>
            <Button id="${class.name}adding" onClick={this.handleShow}>
                Add ${class.name}
            </Button>
            <Modal
                    show={this.state.show}
                    onHide={this.handleClose}
                    size="lg"
                    aria-labelledby="contained-modal-title-vcenter"
                    centered = "true"
            >
                <Modal.Header closeButton>
                    <Modal.Title id="contained-modal-title-vcenter">
                        Add ${class.name}
                    </Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <form onSubmit={this.add${class.name}} id="add${class.name}Form">
                        <div className="form-group">
                            <#list properties as property>
                                <#if property.upper == 1 && property.type == "String">
                                    <label htmlFor="${property.name}">${property.name}</label>
                                    <input type="text"
                                           className="form-control form-control-sm"
                                           id="${property.name}"
                                           name="${property.name}"
                                           onChange={this.handleChange}
                                           placeholder="Enter ${property.name}"
                                    />
                                    <br/>
                                </#if>
                                <#if property.upper == 1 && property.type == "Long">
                                    <label htmlFor="${property.name}">${property.name}</label>
                                    <input type="number"
                                           className="form-control form-control-sm"
                                           id="${property.name}"
                                           name="${property.name}"
                                           onChange={this.handleChange}
                                           placeholder="Enter ${property.name}"
                                    />
                                    <br/>
                                </#if>
                            </#list>
                            <#list class.FMLinkedProperty as linkedP>
                                <#if linkedP.upper == 1>
                                    ${linkedP.name}: 0,
                                <#else>
                                    <label htmlFor="${linkedP.name}">${linkedP.name}</label>
                                    <Select className="selectoptions" multi={true}
                                    onChange={entry => { this.setState({ ${linkedP.name}name: entry.label});}}
                                    value={this.state.${linkedP.name}name.label}
                                    options={this.state.${linkedP.name}s.map((type, i) => {return { value: type.name, label: type.name };})}
                                    />
                                </#if>
                            </#list>
                        </div>
                        <hr/>
                        <Button className="dugmad" variant="secondary" className="dugme2dr" onClick={this.handleClose}>Close</Button>
                        <Button type="submit" variant="success" className="dugme1dr">Create</Button>
                    </form>
                </Modal.Body>
            </Modal>
        </div>

        );
    }
}

export default Add${class.name};
