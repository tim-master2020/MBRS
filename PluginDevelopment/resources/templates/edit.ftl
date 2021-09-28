import React from 'react';
import { Modal, Button } from "react-bootstrap";
import Swal from 'sweetalert2';
import withReactContent from 'sweetalert2-react-content';
import axios from 'axios'
import Select from 'react-select';

const TypeCreatedAlert = withReactContent(Swal)

class Edit${class.name} extends React.Component {

    constructor(props) {
        super(props);

        this.handleShow = this.handleShow.bind(this);
        this.handleClose = this.handleClose.bind(this);
        this.handleChange = this.handleChange.bind(this);

        this.SendUpdateRequest = this.SendUpdateRequest.bind(this);

        this.state = {
            show: false,
            id: this.props.id,
            <#list properties as property>
                <#if property.upper == 1 && property.type == "String">
                    ${property.name}: this.props.content.${property.name},
                </#if>
                <#if property.upper == 1 && property.type == "Long">
                    ${property.name}: 0,
                </#if>
            </#list>
        };
    }

    SendUpdateRequest = event => {
        event.preventDefault();

        this.state.name = this.props.content.name;

        axios.put("http://localhost:8081/api/${class.name}",this.state).then(
        (resp) => this.onSuccessHandler(resp),
        (resp) => this.onErrorHandler(resp)
        );
    }

    onErrorHandler(resp) {
        TypeCreatedAlert.fire({
        title: "Error occured",
        text: '',
        type: "error",
        button: true,
        icon: 'error'
        });
    }

    onSuccessHandler(resp) {
        TypeCreatedAlert.fire({
        title: "${class.name} updated successfully",
        text: "",
        type: "success",
        icon: 'success'
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

    render() {
        return (
        <div>
            <Button variant="outline-primary" id="examedit" onClick={this.handleShow}>
                Edit
            </Button>
            <Modal
                    show={this.state.show}
                    onHide={this.handleClose}
                    size="lg"
                    aria-labelledby="contained-modal-title-vcenter"
                    centered = "true"
            >
                <Modal.Header>
                    <Modal.Title id="contained-modal-title-vcenter">
                        Edit ${class.name}
                    </Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <form onSubmit={this.SendUpdateRequest} id="edit${class.name}form">
                        <div className="form-group">
                            <#list properties as property>
                                <#if property.upper == 1 && property.type == "String">
                                    <p>${property.name}: </p>
                                    <br/>
                                    <input type="text"
                                           className="form-control form-control-sm"
                                           id="${property.name}"
                                           name="${property.name}"
                                           defaultValue={this.props.content.${property.name}}
                                           onChange={this.handleChange}
                                           placeholder={this.props.content.${property.name}}
                                           required
                                    />
                                    <br/>
                                </#if>
                                <#if property.upper == 1 && property.type == "Long">
                                    <p>${property.name}: </p>
                                    <br/>
                                    <input type="number"
                                           className="form-control form-control-sm"
                                           id="${property.name}"
                                           defaultValue={this.props.content.${property.name}}
                                           name="${property.name}"
                                           onChange={this.handleChange}
                                           placeholder={this.props.content.${property.name}}
                                           required
                                    />
                                    <br/>
                                </#if>
                                <br/>
                                <#list class.FMLinkedProperty as linkedP>
                                    <label htmlFor="${linkedP.name}">${linkedP.name}</label>
                                    <Select className="selectoptions" multi={true}
                                            onChange={entry => { this.setState({ ${linkedP.name}: entry.value});}}
                                    value={this.state.${linkedP.name}.label}
                                    options={this.state.${linkedP.name}s.map((type, i) => {return { value: type.id, label: type.name };})}
                                    />
                                </#list>
                            </#list>
                        </div>
                        <hr/>
                        <Button className="dugmad" variant="secondary" className="dugme2dr" onClick={this.handleClose}>Close</Button>
                        <Button type="submit" className="edit${class.name}Button">Ok</Button>

                    </form>
                </Modal.Body>
            </Modal>
        </div>

        );
    }
}

export default Edit${class.name};
