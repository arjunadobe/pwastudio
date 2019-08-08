import React, { Component } from 'react';
import CategoryList from 'parentComponents/CategoryList';
import BannerShow from '../../components/Banner';

export default class CMS extends Component {
    render() {
        return (
            <div>
                <div>
                    <BannerShow />
                </div>
                <div>
                    <CategoryList title="Shop by category" id={2} />
                </div>
            </div>
        );
    }
}
