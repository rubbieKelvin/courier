.pragma library

function fromString(source, data){
	source = "data:image/svg+xml;utf8, "+source
	for (const [key, value] of Object.entries(data || {})){
		source = source.replace(key, value)
	}
	return source
}

const stickers = [
	`<svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
	<g filter="url(#filter0_i)">
	<path d="M128 30.2436V97.7124C128.004 101.688 127.224 105.626 125.705 109.301C124.186 112.975 121.958 116.314 119.148 119.127C116.338 121.94 113.001 124.171 109.328 125.694C105.655 127.216 101.718 128 97.7417 128H30.273C22.2478 127.996 14.5522 124.807 8.87623 119.134C3.20021 113.461 0.00778584 105.767 1.42309e-05 97.7417V30.2729C-0.00384206 26.2976 0.776073 22.3605 2.29515 18.6868C3.81422 15.0132 6.04265 11.675 8.85297 8.86333C11.6633 6.05165 15.0003 3.82161 18.6733 2.30075C22.3462 0.779896 26.2829 -0.00192622 30.2583 3.56376e-06H97.7271C101.701 -0.00192302 105.636 0.778823 109.308 2.29766C112.979 3.81651 116.316 6.0437 119.127 8.85208C121.938 11.6605 124.169 14.995 125.691 18.6654C127.214 22.3358 127.998 26.27 128 30.2436V30.2436Z" fill="$tone"/>
	</g>
	<path d="M88.4289 89.8601H39.9247C39.7044 89.9325 39.4701 89.9516 39.241 89.9159C39.0118 89.8803 38.7944 89.7908 38.6066 89.6548C38.4188 89.5188 38.2659 89.3402 38.1604 89.1337C38.055 88.9272 38 88.6986 38 88.4667C38 88.2348 38.055 88.0063 38.1604 87.7997C38.2659 87.5932 38.4188 87.4146 38.6066 87.2787C38.7944 87.1427 39.0118 87.0532 39.241 87.0175C39.4701 86.9818 39.7044 87.0009 39.9247 87.0733H88.4289C88.6492 87.0009 88.8835 86.9818 89.1126 87.0175C89.3417 87.0532 89.5591 87.1427 89.7469 87.2787C89.9348 87.4146 90.0877 87.5932 90.1931 87.7997C90.2986 88.0063 90.3536 88.2348 90.3536 88.4667C90.3536 88.6986 90.2986 88.9272 90.1931 89.1337C90.0877 89.3402 89.9348 89.5188 89.7469 89.6548C89.5591 89.7908 89.3417 89.8803 89.1126 89.9159C88.8835 89.9516 88.6492 89.9325 88.4289 89.8601V89.8601Z" fill="black"/>
	<g clip-path="url(#clip0)">
	<path d="M107 51.0396C107 43.8381 101.18 38 94 38C86.8203 38 81 43.8381 81 51.0396V54.9604C81 62.1619 86.8203 68 94 68C101.18 68 107 62.1619 107 54.9604V51.0396Z" fill="black"/>
	<path d="M89.7856 47.5336C91.0493 47.5336 92.0737 46.5092 92.0737 45.2456C92.0737 43.9819 91.0493 42.9575 89.7856 42.9575C88.522 42.9575 87.4976 43.9819 87.4976 45.2456C87.4976 46.5092 88.522 47.5336 89.7856 47.5336Z" fill="white"/>
	<path opacity="0.1" d="M94.0244 56.3486C96.9649 56.3486 99.3486 53.9649 99.3486 51.0244C99.3486 48.084 96.9649 45.7003 94.0244 45.7003C91.084 45.7003 88.7003 48.084 88.7003 51.0244C88.7003 53.9649 91.084 56.3486 94.0244 56.3486Z" fill="white"/>
	<path d="M46 51.0396C46 43.8381 40.1797 38 33 38C25.8203 38 20 43.8381 20 51.0396V54.9604C20 62.162 25.8203 68 33 68C40.1797 68 46 62.162 46 54.9604V51.0396Z" fill="black"/>
	<path d="M28.7856 47.5336C30.0493 47.5336 31.0737 46.5092 31.0737 45.2456C31.0737 43.9819 30.0493 42.9575 28.7856 42.9575C27.522 42.9575 26.4976 43.9819 26.4976 45.2456C26.4976 46.5092 27.522 47.5336 28.7856 47.5336Z" fill="white"/>
	<path opacity="0.1" d="M33.0244 56.3486C35.9649 56.3486 38.3486 53.9649 38.3486 51.0244C38.3486 48.084 35.9649 45.7003 33.0244 45.7003C30.084 45.7003 27.7003 48.084 27.7003 51.0244C27.7003 53.9649 30.084 56.3486 33.0244 56.3486Z" fill="white"/>
	</g>
	<defs>
	<filter id="filter0_i" x="0" y="0" width="128" height="128" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
	<feFlood flood-opacity="0" result="BackgroundImageFix"/>
	<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
	<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
	<feOffset dx="-6" dy="-6"/>
	<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
	<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.04 0"/>
	<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
	</filter>
	<clipPath id="clip0">
	<rect width="87.4601" height="29.9649" fill="white" transform="translate(20 38)"/>
	</clipPath>
	</defs>
	</svg>
	`,
	`<svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
	<g filter="url(#filter0_i)">
	<path d="M128 30.2436V97.7124C128.004 101.688 127.224 105.626 125.705 109.301C124.186 112.975 121.958 116.314 119.148 119.127C116.338 121.94 113.001 124.171 109.328 125.694C105.655 127.216 101.718 128 97.7417 128H30.273C22.2478 127.996 14.5522 124.807 8.87623 119.134C3.20021 113.461 0.00778584 105.767 1.42309e-05 97.7417V30.2729C-0.00384206 26.2976 0.776073 22.3605 2.29515 18.6868C3.81422 15.0132 6.04265 11.675 8.85297 8.86333C11.6633 6.05165 15.0003 3.82161 18.6733 2.30075C22.3462 0.779896 26.2829 -0.00192622 30.2583 3.56376e-06H97.7271C101.701 -0.00192302 105.636 0.778823 109.308 2.29766C112.979 3.81651 116.316 6.0437 119.127 8.85208C121.938 11.6605 124.169 14.995 125.691 18.6654C127.214 22.3358 127.998 26.27 128 30.2436V30.2436Z" fill="$tone"/>
	</g>
	<path d="M64.7677 102C48.276 102 29.803 92.7934 28.0111 72.6329C27.9647 72.2649 28.0653 71.8934 28.2907 71.6001C28.5161 71.3069 28.8478 71.1159 29.213 71.0691C29.5781 71.0224 29.9467 71.1238 30.2377 71.351C30.5287 71.5781 30.7182 71.9125 30.7645 72.2805C32.3671 90.7524 49.4998 99.1661 64.7677 99.1661C86.3439 99.1661 97.1393 85.6425 98.2756 72.2805C98.3018 71.9168 98.4697 71.5783 98.7426 71.3389C99.0156 71.0996 99.3715 70.9788 99.7325 71.0031C100.085 71.0496 100.409 71.2247 100.642 71.4952C100.876 71.7657 101.003 72.1129 101 72.4714C99.3391 92.8375 81.0846 101.985 64.7969 102H64.7677Z" fill="black"/>
	<path d="M97.4423 63.9193H90.8421C81.1178 63.9193 81.1178 63.9927 81.1178 54.195V50.8949C81.1217 47.4418 82.4951 44.1313 84.9368 41.6896C87.3786 39.2479 90.6891 37.8744 94.1422 37.8705V37.8705C97.5953 37.8744 100.906 39.2479 103.348 41.6896C105.789 44.1313 107.163 47.4418 107.167 50.8949V54.2684C107.137 63.9927 107.137 63.9193 97.4423 63.9193Z" fill="black"/>
	<path d="M89.7692 47.5158C91.0305 47.5158 92.053 46.4933 92.053 45.232C92.053 43.9707 91.0305 42.9482 89.7692 42.9482C88.5079 42.9482 87.4854 43.9707 87.4854 45.232C87.4854 46.4933 88.5079 47.5158 89.7692 47.5158Z" fill="white"/>
	<path opacity="0.1" d="M93.9999 56.3142C96.9349 56.3142 99.3141 53.935 99.3141 51C99.3141 48.0651 96.9349 45.6859 93.9999 45.6859C91.065 45.6859 88.6858 48.0651 88.6858 51C88.6858 53.935 91.065 56.3142 93.9999 56.3142Z" fill="white"/>
	<path d="M36.4423 63.9193H29.8421C20.1178 63.9193 20.1178 63.9927 20.1178 54.195V50.8949C20.1217 47.4418 21.4951 44.1313 23.9368 41.6896C26.3786 39.2479 29.6891 37.8744 33.1422 37.8705V37.8705C36.5953 37.8744 39.9059 39.2479 42.3476 41.6896C44.7893 44.1313 46.1627 47.4418 46.1666 50.8949V54.2684C46.1373 63.9927 46.1373 63.9193 36.4423 63.9193Z" fill="black"/>
	<path d="M28.8737 47.5336C30.1374 47.5336 31.1618 46.5092 31.1618 45.2456C31.1618 43.9819 30.1374 42.9575 28.8737 42.9575C27.61 42.9575 26.5856 43.9819 26.5856 45.2456C26.5856 46.5092 27.61 47.5336 28.8737 47.5336Z" fill="white"/>
	<path opacity="0.1" d="M33.1125 56.3486C36.0529 56.3486 38.4366 53.9649 38.4366 51.0244C38.4366 48.084 36.0529 45.7003 33.1125 45.7003C30.172 45.7003 27.7883 48.084 27.7883 51.0244C27.7883 53.9649 30.172 56.3486 33.1125 56.3486Z" fill="white"/>
	<defs>
	<filter id="filter0_i" x="0" y="0" width="128" height="128" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
	<feFlood flood-opacity="0" result="BackgroundImageFix"/>
	<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
	<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
	<feOffset dx="-6" dy="-6"/>
	<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
	<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.04 0"/>
	<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
	</filter>
	</defs>
	</svg>	
	`,
	`<svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
	<g filter="url(#filter0_i)">
	<path d="M128 30.2436V97.7124C128.004 101.688 127.224 105.626 125.705 109.301C124.186 112.975 121.958 116.314 119.148 119.127C116.338 121.94 113.001 124.171 109.328 125.694C105.655 127.216 101.718 128 97.7417 128H30.273C22.2478 127.996 14.5522 124.807 8.87623 119.134C3.20021 113.461 0.00778584 105.767 1.42309e-05 97.7417V30.2729C-0.00384206 26.2976 0.776073 22.3605 2.29515 18.6868C3.81422 15.0132 6.04265 11.675 8.85297 8.86333C11.6633 6.05165 15.0003 3.82161 18.6733 2.30075C22.3462 0.779896 26.2829 -0.00192622 30.2583 3.56376e-06H97.7271C101.701 -0.00192302 105.636 0.778823 109.308 2.29766C112.979 3.81651 116.316 6.0437 119.127 8.85208C121.938 11.6605 124.169 14.995 125.691 18.6654C127.214 22.3358 127.998 26.27 128 30.2436V30.2436Z" fill="$tone"/>
	</g>
	<g style="mix-blend-mode:soft-light" opacity="0.4">
	<path d="M64.3033 49.8949L60.8125 68.2435L64.3033 71.0303V49.8949Z" fill="black"/>
	</g>
	<path fill-rule="evenodd" clip-rule="evenodd" d="M28 72C28 116 100 116 100 72C75.7073 80.8676 51.7073 81.1324 28 72Z" fill="white"/>
	<path fill-rule="evenodd" clip-rule="evenodd" d="M35 92C49.3493 107.799 78.3493 108.002 93 92.5819C73.8493 96.4261 54.0638 96.2276 35 92V92Z" fill="#DDDBDB"/>
	<path d="M64.0365 105.993C54.8716 106.16 45.9257 103.176 38.6834 97.537C31.0746 91.3668 27 82.544 27 72.065C27.0016 71.8952 27.0436 71.7282 27.1223 71.5778C27.201 71.4274 27.3143 71.298 27.4527 71.2003C27.5931 71.1067 27.7534 71.0473 27.9208 71.027C28.0882 71.0066 28.258 71.0258 28.4166 71.0831C51.3308 79.8766 75.2672 79.8766 99.5395 71.0831C99.7002 71.015 99.8751 70.9881 100.049 71.0048C100.222 71.0215 100.389 71.0812 100.534 71.1786C100.679 71.276 100.797 71.408 100.878 71.5627C100.96 71.7175 101.002 71.8901 101 72.065C101 82.544 96.9838 91.3668 89.3165 97.537C82.0916 103.156 73.1757 106.138 64.0365 105.993V105.993ZM29.176 73.5892C29.9939 94.4006 47.6213 103.912 64.0365 103.912C80.4517 103.912 98.1521 94.4006 98.8969 73.5599C75.1212 81.8698 51.6813 81.8845 29.176 73.5892Z" fill="black"/>
	<g style="mix-blend-mode:soft-light" opacity="0.4">
	<path d="M49 107C53.5022 112.161 74.0316 112.503 79 107C69.1186 109.224 58.8814 109.224 49 107V107Z" fill="black"/>
	</g>
	<path d="M97.4423 63.9193H90.8421C81.1178 63.9193 81.1178 63.9927 81.1178 54.195V50.8949C81.1217 47.4418 82.4951 44.1313 84.9368 41.6896C87.3786 39.2479 90.6891 37.8744 94.1422 37.8705V37.8705C97.5953 37.8744 100.906 39.2479 103.348 41.6896C105.789 44.1313 107.163 47.4418 107.167 50.8949V54.2684C107.137 63.9927 107.137 63.9193 97.4423 63.9193Z" fill="black"/>
	<path d="M89.7692 47.5158C91.0305 47.5158 92.053 46.4933 92.053 45.232C92.053 43.9707 91.0305 42.9482 89.7692 42.9482C88.5079 42.9482 87.4854 43.9707 87.4854 45.232C87.4854 46.4933 88.5079 47.5158 89.7692 47.5158Z" fill="white"/>
	<path opacity="0.1" d="M93.9999 56.3142C96.9349 56.3142 99.3141 53.935 99.3141 51C99.3141 48.0651 96.9349 45.6859 93.9999 45.6859C91.065 45.6859 88.6858 48.0651 88.6858 51C88.6858 53.935 91.065 56.3142 93.9999 56.3142Z" fill="white"/>
	<path d="M36.4423 63.9193H29.8421C20.1178 63.9193 20.1178 63.9927 20.1178 54.195V50.8949C20.1217 47.4418 21.4951 44.1313 23.9368 41.6896C26.3786 39.2479 29.6891 37.8744 33.1422 37.8705V37.8705C36.5953 37.8744 39.9059 39.2479 42.3476 41.6896C44.7893 44.1313 46.1627 47.4418 46.1666 50.8949V54.2684C46.1373 63.9927 46.1373 63.9193 36.4423 63.9193Z" fill="black"/>
	<path d="M28.8737 47.5336C30.1374 47.5336 31.1618 46.5092 31.1618 45.2456C31.1618 43.9819 30.1374 42.9575 28.8737 42.9575C27.61 42.9575 26.5856 43.9819 26.5856 45.2456C26.5856 46.5092 27.61 47.5336 28.8737 47.5336Z" fill="white"/>
	<path opacity="0.1" d="M33.1125 56.3486C36.0529 56.3486 38.4366 53.9649 38.4366 51.0244C38.4366 48.084 36.0529 45.7003 33.1125 45.7003C30.172 45.7003 27.7883 48.084 27.7883 51.0244C27.7883 53.9649 30.172 56.3486 33.1125 56.3486Z" fill="white"/>
	<defs>
	<filter id="filter0_i" x="0" y="0" width="128" height="128" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
	<feFlood flood-opacity="0" result="BackgroundImageFix"/>
	<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
	<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
	<feOffset dx="-6" dy="-6"/>
	<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
	<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.04 0"/>
	<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
	</filter>
	</defs>
	</svg>
	`,
	`<svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
	<g filter="url(#filter0_i)">
	<path d="M128 30.2436V97.7124C128.004 101.688 127.224 105.626 125.705 109.301C124.186 112.975 121.958 116.314 119.148 119.127C116.338 121.94 113.001 124.171 109.328 125.694C105.655 127.216 101.718 128 97.7417 128H30.273C22.2478 127.996 14.5522 124.807 8.87623 119.134C3.20021 113.461 0.00778584 105.767 1.42309e-05 97.7417V30.2729C-0.00384206 26.2976 0.776073 22.3605 2.29515 18.6868C3.81422 15.0132 6.04265 11.675 8.85297 8.86333C11.6633 6.05165 15.0003 3.82161 18.6733 2.30075C22.3462 0.779896 26.2829 -0.00192622 30.2583 3.56376e-06H97.7271C101.701 -0.00192302 105.636 0.778823 109.308 2.29766C112.979 3.81651 116.316 6.0437 119.127 8.85208C121.938 11.6605 124.169 14.995 125.691 18.6654C127.214 22.3358 127.998 26.27 128 30.2436V30.2436Z" fill="$tone"/>
	</g>
	<path d="M64.5423 101H63.789C54.0857 100.782 42.994 95.7096 40.0845 84.8527C40.0178 84.6722 39.9901 84.48 40.0031 84.2884C40.0162 84.0968 40.0697 83.9099 40.1603 83.7398C40.2509 83.5697 40.3766 83.4201 40.5293 83.3005C40.6819 83.1809 40.8583 83.0939 41.0471 83.0452C41.2359 82.9965 41.4329 82.987 41.6256 83.0175C41.8183 83.0479 42.0024 83.1176 42.1662 83.2221C42.3299 83.3265 42.4698 83.4635 42.5767 83.6241C42.6837 83.7848 42.7554 83.9656 42.7873 84.1551C45.3423 93.6167 55.2081 98.0496 63.8481 98.2385C72.0893 98.3984 82.8856 94.3977 86.312 83.6716C86.4917 83.4182 86.7488 83.2278 87.046 83.128C87.3431 83.0281 87.6649 83.0241 87.9645 83.1165C88.2641 83.2088 88.5261 83.3927 88.7123 83.6415C88.8985 83.8903 88.9993 84.191 89 84.5C85.8542 94.3105 76.2985 101 64.5423 101Z" fill="black"/>
	<path d="M36.4109 64H29.823C20.117 64 20.117 64.0732 20.117 54.2939V50.2094C20.115 48.6068 20.429 47.0194 21.041 45.5382C21.653 44.057 22.551 42.7109 23.6836 41.577C24.8161 40.443 26.1611 39.5434 27.6416 38.9297C29.1221 38.3159 30.7091 38 32.3118 38H33.9221C35.5248 38 37.1118 38.3159 38.5923 38.9297C40.0728 39.5434 41.4178 40.443 42.5503 41.577C43.6829 42.7109 44.5809 44.057 45.1929 45.5382C45.8049 47.0194 46.1189 48.6068 46.1169 50.2094V54.3671C46.0877 64.0732 46.0877 64 36.4109 64Z" fill="black"/>
	<path d="M28.8737 47.5336C30.1374 47.5336 31.1618 46.5092 31.1618 45.2456C31.1618 43.9819 30.1374 42.9575 28.8737 42.9575C27.61 42.9575 26.5856 43.9819 26.5856 45.2456C26.5856 46.5092 27.61 47.5336 28.8737 47.5336Z" fill="white"/>
	<path opacity="0.1" d="M33.1125 56.3486C36.0529 56.3486 38.4366 53.9649 38.4366 51.0244C38.4366 48.084 36.0529 45.7003 33.1125 45.7003C30.172 45.7003 27.7883 48.084 27.7883 51.0244C27.7883 53.9649 30.172 56.3486 33.1125 56.3486Z" fill="white"/>
	<path d="M82.7 57C82.5289 56.9982 82.3592 56.9685 82.1973 56.9121C81.9839 56.8453 81.7855 56.7361 81.6136 56.5908C81.4416 56.4455 81.2996 56.267 81.1955 56.0655C81.0914 55.864 81.0273 55.6435 81.007 55.4167C80.9867 55.1899 81.0105 54.9612 81.0771 54.7438C81.8905 51.9013 83.5951 49.4093 85.9296 47.6496C88.2642 45.8899 91.1 44.9596 94.0024 45.0013V45.0013C96.9015 44.9742 99.7305 45.91 102.062 47.6676C104.394 49.4251 106.102 51.9089 106.928 54.7438C107.058 55.1848 107.011 55.6604 106.799 56.0666C106.586 56.4729 106.225 56.7768 105.793 56.9121C105.58 56.9821 105.355 57.0079 105.133 56.9881C104.91 56.9684 104.693 56.9033 104.495 56.7969C104.297 56.6904 104.122 56.5447 103.98 56.3683C103.838 56.1918 103.731 55.9882 103.668 55.7694C103.045 53.638 101.76 51.771 100.006 50.4497C98.2523 49.1285 96.125 48.4246 93.945 48.4442C91.7747 48.4373 89.6605 49.1471 87.9184 50.4674C86.1763 51.7877 84.8998 53.6477 84.2797 55.7694C84.1732 56.1158 83.9642 56.4201 83.6813 56.6404C83.3984 56.8608 83.0556 56.9864 82.7 57V57Z" fill="black"/>
	<defs>
	<filter id="filter0_i" x="0" y="0" width="128" height="128" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
	<feFlood flood-opacity="0" result="BackgroundImageFix"/>
	<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
	<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
	<feOffset dx="-6" dy="-6"/>
	<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
	<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.04 0"/>
	<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
	</filter>
	</defs>
	</svg>
	`,
	`<svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
	<g filter="url(#filter0_i)">
	<path d="M128 30.2436V97.7124C128.004 101.688 127.224 105.626 125.705 109.301C124.186 112.975 121.958 116.314 119.148 119.127C116.338 121.94 113.001 124.171 109.328 125.694C105.655 127.216 101.718 128 97.7417 128H30.273C22.2478 127.996 14.5522 124.807 8.87623 119.134C3.20021 113.461 0.00778584 105.767 1.42309e-05 97.7417V30.2729C-0.00384206 26.2976 0.776073 22.3605 2.29515 18.6868C3.81422 15.0132 6.04265 11.675 8.85297 8.86333C11.6633 6.05165 15.0003 3.82161 18.6733 2.30075C22.3462 0.779896 26.2829 -0.00192622 30.2583 3.56376e-06H97.7271C101.701 -0.00192302 105.636 0.778823 109.308 2.29766C112.979 3.81651 116.316 6.0437 119.127 8.85208C121.938 11.6605 124.169 14.995 125.691 18.6654C127.214 22.3358 127.998 26.27 128 30.2436V30.2436Z" fill="$tone"/>
	</g>
	<g style="mix-blend-mode:soft-light" filter="url(#filter1_f)">
	<path d="M37.8885 66H27.1115C22.6317 66 19 69.5817 19 74C19 78.4183 22.6317 82 27.1115 82H37.8885C42.3683 82 46 78.4183 46 74C46 69.5817 42.3683 66 37.8885 66Z" fill="#C140A3"/>
	</g>
	<g style="mix-blend-mode:soft-light" filter="url(#filter2_f)">
	<path d="M99.9043 66H89.0957C84.6246 66 81 69.5785 81 73.9929V74.0071C81 78.4215 84.6246 82 89.0957 82H99.9043C104.375 82 108 78.4215 108 74.0071V73.9929C108 69.5785 104.375 66 99.9043 66Z" fill="#C140A3"/>
	</g>
	<path d="M64.5423 83H63.789C54.0857 83.218 42.994 88.2904 40.0845 99.1473C40.0178 99.3278 39.9901 99.52 40.0031 99.7116C40.0162 99.9032 40.0697 100.09 40.1603 100.26C40.2509 100.43 40.3766 100.58 40.5293 100.7C40.6819 100.819 40.8583 100.906 41.0471 100.955C41.2359 101.004 41.4329 101.013 41.6256 100.983C41.8183 100.952 42.0024 100.882 42.1662 100.778C42.3299 100.673 42.4698 100.537 42.5767 100.376C42.6837 100.215 42.7554 100.034 42.7873 99.8449C45.3423 90.3833 55.2081 85.9504 63.8481 85.7615C72.0893 85.6016 82.8856 89.6023 86.312 100.328C86.4917 100.582 86.7488 100.772 87.046 100.872C87.3431 100.972 87.6649 100.976 87.9645 100.884C88.2641 100.791 88.5261 100.607 88.7123 100.358C88.8985 100.11 88.9993 99.809 89 99.5C85.8542 89.6895 76.2985 83 64.5423 83Z" fill="black"/>
	<g clip-path="url(#clip0)">
	<path d="M107 51.0396C107 43.8381 101.18 38 94 38C86.8203 38 81 43.8381 81 51.0396V54.9604C81 62.1619 86.8203 68 94 68C101.18 68 107 62.1619 107 54.9604V51.0396Z" fill="black"/>
	<path d="M89.7856 47.5336C91.0493 47.5336 92.0737 46.5092 92.0737 45.2456C92.0737 43.9819 91.0493 42.9575 89.7856 42.9575C88.522 42.9575 87.4976 43.9819 87.4976 45.2456C87.4976 46.5092 88.522 47.5336 89.7856 47.5336Z" fill="white"/>
	<path opacity="0.1" d="M94.0244 56.3486C96.9649 56.3486 99.3486 53.9649 99.3486 51.0244C99.3486 48.084 96.9649 45.7003 94.0244 45.7003C91.084 45.7003 88.7003 48.084 88.7003 51.0244C88.7003 53.9649 91.084 56.3486 94.0244 56.3486Z" fill="white"/>
	<path d="M46 51.0396C46 43.8381 40.1797 38 33 38C25.8203 38 20 43.8381 20 51.0396V54.9604C20 62.162 25.8203 68 33 68C40.1797 68 46 62.162 46 54.9604V51.0396Z" fill="black"/>
	<path d="M28.7856 47.5336C30.0493 47.5336 31.0737 46.5092 31.0737 45.2456C31.0737 43.9819 30.0493 42.9575 28.7856 42.9575C27.522 42.9575 26.4976 43.9819 26.4976 45.2456C26.4976 46.5092 27.522 47.5336 28.7856 47.5336Z" fill="white"/>
	<path opacity="0.1" d="M33.0244 56.3486C35.9649 56.3486 38.3486 53.9649 38.3486 51.0244C38.3486 48.084 35.9649 45.7003 33.0244 45.7003C30.084 45.7003 27.7002 48.084 27.7002 51.0244C27.7002 53.9649 30.084 56.3486 33.0244 56.3486Z" fill="white"/>
	</g>
	<defs>
	<filter id="filter0_i" x="0" y="0" width="128" height="128" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
	<feFlood flood-opacity="0" result="BackgroundImageFix"/>
	<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
	<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
	<feOffset dx="-6" dy="-6"/>
	<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
	<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.04 0"/>
	<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
	</filter>
	<filter id="filter1_f" x="9" y="56" width="47" height="36" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
	<feFlood flood-opacity="0" result="BackgroundImageFix"/>
	<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
	<feGaussianBlur stdDeviation="5" result="effect1_foregroundBlur"/>
	</filter>
	<filter id="filter2_f" x="71" y="56" width="47" height="36" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
	<feFlood flood-opacity="0" result="BackgroundImageFix"/>
	<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
	<feGaussianBlur stdDeviation="5" result="effect1_foregroundBlur"/>
	</filter>
	<clipPath id="clip0">
	<rect width="87.4601" height="29.9649" fill="white" transform="translate(20 38)"/>
	</clipPath>
	</defs>
	</svg>
	`,
	`<svg width="128" height="128" viewBox="0 0 128 128" fill="none" xmlns="http://www.w3.org/2000/svg">
	<g filter="url(#filter0_i)">
	<path d="M128 30.2436V97.7124C128.004 101.688 127.224 105.626 125.705 109.301C124.186 112.975 121.958 116.314 119.148 119.127C116.338 121.94 113.001 124.171 109.328 125.694C105.655 127.216 101.718 128 97.7417 128H30.273C22.2478 127.996 14.5522 124.807 8.87623 119.134C3.20021 113.461 0.00778584 105.767 1.42309e-05 97.7417V30.2729C-0.00384206 26.2976 0.776073 22.3605 2.29515 18.6868C3.81422 15.0132 6.04265 11.675 8.85297 8.86333C11.6633 6.05165 15.0003 3.82161 18.6733 2.30075C22.3462 0.779896 26.2829 -0.00192622 30.2583 3.56376e-06H97.7271C101.701 -0.00192302 105.636 0.778823 109.308 2.29766C112.979 3.81651 116.316 6.0437 119.127 8.85208C121.938 11.6605 124.169 14.995 125.691 18.6654C127.214 22.3358 127.998 26.27 128 30.2436V30.2436Z" fill="$tone"/>
	</g>
	<g style="mix-blend-mode:soft-light" filter="url(#filter1_f)">
	<path d="M37.8885 66H27.1115C22.6317 66 19 69.5817 19 74C19 78.4183 22.6317 82 27.1115 82H37.8885C42.3683 82 46 78.4183 46 74C46 69.5817 42.3683 66 37.8885 66Z" fill="#C140A3"/>
	</g>
	<g style="mix-blend-mode:soft-light" filter="url(#filter2_f)">
	<path d="M99.9043 66H89.0957C84.6246 66 81 69.5785 81 73.9929V74.0071C81 78.4215 84.6246 82 89.0957 82H99.9043C104.375 82 108 78.4215 108 74.0071V73.9929C108 69.5785 104.375 66 99.9043 66Z" fill="#C140A3"/>
	</g>
	<path fill-rule="evenodd" clip-rule="evenodd" d="M28 72C28 116 100 116 100 72C75.7073 80.8676 51.7073 81.1324 28 72Z" fill="white"/>
	<path fill-rule="evenodd" clip-rule="evenodd" d="M35 92C49.3493 107.799 78.3493 108.002 93 92.5819C73.8493 96.4261 54.0638 96.2276 35 92V92Z" fill="#DDDBDB"/>
	<path d="M64.0365 105.993C54.8716 106.16 45.9257 103.176 38.6834 97.537C31.0746 91.3668 27 82.544 27 72.065C27.0016 71.8952 27.0436 71.7282 27.1223 71.5778C27.201 71.4274 27.3143 71.298 27.4527 71.2003C27.5931 71.1067 27.7534 71.0473 27.9208 71.027C28.0882 71.0066 28.258 71.0258 28.4166 71.0831C51.3308 79.8766 75.2672 79.8766 99.5395 71.0831C99.7002 71.015 99.8751 70.9881 100.049 71.0048C100.222 71.0215 100.389 71.0812 100.534 71.1786C100.679 71.276 100.797 71.408 100.878 71.5627C100.96 71.7175 101.002 71.8901 101 72.065C101 82.544 96.9838 91.3668 89.3165 97.537C82.0916 103.156 73.1757 106.138 64.0365 105.993V105.993ZM29.176 73.5892C29.9939 94.4006 47.6213 103.912 64.0365 103.912C80.4517 103.912 98.1521 94.4006 98.8969 73.5599C75.1212 81.8698 51.6813 81.8845 29.176 73.5892Z" fill="black"/>
	<g style="mix-blend-mode:soft-light" opacity="0.4">
	<path d="M49 107C53.5022 112.161 74.0316 112.503 79 107C69.1186 109.224 58.8814 109.224 49 107V107Z" fill="black"/>
	</g>
	<path d="M82.7 57C82.5289 56.9982 82.3592 56.9685 82.1973 56.9121C81.9839 56.8453 81.7855 56.7361 81.6136 56.5908C81.4416 56.4455 81.2996 56.267 81.1955 56.0655C81.0914 55.864 81.0273 55.6435 81.007 55.4167C80.9867 55.1899 81.0105 54.9612 81.0771 54.7438C81.8905 51.9013 83.5951 49.4093 85.9296 47.6496C88.2642 45.8899 91.1 44.9596 94.0024 45.0013V45.0013C96.9015 44.9742 99.7305 45.91 102.062 47.6676C104.394 49.4251 106.102 51.9089 106.928 54.7438C107.058 55.1848 107.011 55.6604 106.799 56.0666C106.586 56.4729 106.225 56.7768 105.793 56.9121C105.58 56.9821 105.355 57.0079 105.133 56.9881C104.91 56.9684 104.693 56.9033 104.495 56.7969C104.297 56.6904 104.122 56.5447 103.98 56.3683C103.838 56.1918 103.731 55.9882 103.668 55.7694C103.045 53.638 101.76 51.771 100.006 50.4497C98.2523 49.1285 96.125 48.4246 93.945 48.4442C91.7747 48.4373 89.6605 49.1471 87.9184 50.4674C86.1763 51.7877 84.8998 53.6477 84.2797 55.7694C84.1732 56.1158 83.9642 56.4201 83.6813 56.6404C83.3984 56.8608 83.0556 56.9864 82.7 57V57Z" fill="black"/>
	<path d="M21.7126 56.9999C21.5413 57.0015 21.3711 56.9717 21.2101 56.912C20.9954 56.8467 20.7956 56.7386 20.6222 56.594C20.4487 56.4494 20.3051 56.2711 20.1996 56.0694C20.0941 55.8678 20.0289 55.6468 20.0076 55.4192C19.9864 55.1917 20.0096 54.9621 20.0759 54.7437C20.8932 51.9037 22.5984 49.4144 24.9314 47.6554C27.2643 45.8964 30.097 44.9642 32.9975 45.0011V45.0011C35.8969 44.9691 38.7273 45.9031 41.0593 47.6614C43.3913 49.4197 45.0976 51.9062 45.9192 54.7437C45.9877 54.9611 46.0131 55.1902 45.9937 55.4176C45.9743 55.6451 45.9106 55.8663 45.8063 56.0683C45.7019 56.2703 45.5591 56.449 45.3862 56.5939C45.2133 56.7387 45.0137 56.8469 44.7993 56.912C44.3671 57.0497 43.899 57.0066 43.4979 56.7923C43.0968 56.5781 42.7955 56.2101 42.66 55.7693C42.0381 53.6403 40.7555 51.775 39.0051 50.454C37.2548 49.1329 35.1315 48.4275 32.9544 48.444V48.444C30.7823 48.4339 28.6655 49.1422 26.921 50.4628C25.1764 51.7834 23.8982 53.6452 23.2776 55.7693C23.1738 56.1146 22.9674 56.4184 22.6871 56.6389C22.4068 56.8593 22.0663 56.9855 21.7126 56.9999V56.9999Z" fill="black"/>
	<defs>
	<filter id="filter0_i" x="0" y="0" width="128" height="128" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
	<feFlood flood-opacity="0" result="BackgroundImageFix"/>
	<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
	<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
	<feOffset dx="-6" dy="-6"/>
	<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
	<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.04 0"/>
	<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
	</filter>
	<filter id="filter1_f" x="9" y="56" width="47" height="36" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
	<feFlood flood-opacity="0" result="BackgroundImageFix"/>
	<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
	<feGaussianBlur stdDeviation="5" result="effect1_foregroundBlur"/>
	</filter>
	<filter id="filter2_f" x="71" y="56" width="47" height="36" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
	<feFlood flood-opacity="0" result="BackgroundImageFix"/>
	<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
	<feGaussianBlur stdDeviation="5" result="effect1_foregroundBlur"/>
	</filter>
	</defs>
	</svg>
	`
]
