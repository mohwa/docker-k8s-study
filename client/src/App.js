import axios from 'axios';
import React, {  useEffect, useCallback, useState } from 'react';

const BACKGROUND_COLORS = ['red', 'blue', 'green'];

const App = () => {
    const [bgColor, setBgColor] = useState('');

    const handleBackgroundColor = useCallback((e) => {
        const { value } = e.target;

        axios.post('api/app_info', { bgColor: value }).then((response) => {
            setBgColor(value);
        });
    }, []);

    useEffect(() => {
        axios.get('api/app_info').then((response) => {
            const { bg_color = '' } = response.data;

            setBgColor(bg_color);
        });
    }, []);

    return (
        <div>
            <form>
                {BACKGROUND_COLORS.map((value, index) => {
                    let checked = false;

                    if (bgColor === value) {
                        checked = true;
                    }

                    return (
                        <span key={index}>
                            <label htmlFor={value}>{ value }</label>
                            <input id={value} name="bg_color" type="radio" value={value} checked={checked} onChange={handleBackgroundColor} />
                        </span>
                    );
                })}
                <div>
                    선택된 배경색:
                    <span
                    style={{
                        width: 10,
                        height: 10,
                        backgroundColor: bgColor,
                        display: 'inline-block'
                    }}>
                        &nbsp;
                    </span>
                </div>
            </form>
        </div>
    );
};

export default App;
