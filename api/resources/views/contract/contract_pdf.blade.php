<h2 style="text-align:center;">Contract</h2>
<table  style="width: 700px;padding-bottom: 14px;" cellspacing="5px" cellpadding="5px">
	<tr>
		<td style="width:200px;font-weight:bold;font-weight:bold;">
			Category:
		</td>
		<td style="width:500px;">
		{{$contract->getCategoryData->name}}
		</td>	
	</tr>
	<tr>
		<td style="width:200px;font-weight:bold;font-weight:bold;">
			Contract Name:
		</td>
		<td>
		{{$contract->name}}
		</td>	
	</tr>
	<tr>
		<td style="width:200px;font-weight:bold;font-weight:bold;">
			Contract Description:
		</td>
		<td>
			{{$contract->description}}
		</td>	
	</tr>
	
	<tr>
		<td style="width:200px;font-weight:bold;font-weight:bold;">
			Owner:
		</td>
		<td>
		{{$contract->getSenderData->shop_name}} ( {{$contract->getSenderData->email}} )
		</td>	
	</tr>
	<tr>
		<td style="width:200px;font-weight:bold;font-weight:bold;">
			Owner Address:
		</td>
		<td>			
		{{$contract->getSenderData->address}}, {{$contract->getSenderData->city}}
		</td>	
	</tr>
	<tr>
		<td style="width:200px;font-weight:bold;font-weight:bold;">
			Recipient:
		</td>
		<td>
			{{$contract->get_receiver_data->name}} ( {{$contract->email}} )
		</td>	
	</tr>
	<tr>
		<td style="width:200px;font-weight:bold;font-weight:bold;">
			Recipient Address:
		</td>
		<td>
			{{$contract->get_receiver_data->address}}, {{$contract->get_receiver_data->city}}
		</td>	
	</tr>
	<tr>
		<td style="width:200px;font-weight:bold;font-weight:bold;">
			Status:
		</td>
		<td>
			@if ($contract->status == 2 && $contract->sender_flag == 1)
				Accepted ( by <b>{{$contract->get_receiver_data->name }}</b> )
			@endif
			@if ($contract->status == 2 && $contract->receiver_flag == 1)
				Accepted ( by <b>{{$contract->getSenderData->shop_name }}</b> )
			@endif
			@if ($contract->status == 3)
				Rejected	
			@endif
			@if ($contract->status == 4)
				Finalized
			@endif
		</td>	
	</tr>
</table>  

<h2>Terms and Conditions *</h2>

@foreach($contract->getContractParts as $key=>$part)
<h3>{{$key+1}}. {{$part->title}}</h3>
<p>{{$part->body}}</p>
@endforeach

<table  style="width: 700px;padding-bottom: 14px;" cellspacing="5px" cellpadding="5px">
	<tr>
		<td style="width:350px;font-weight:bold;font-weight:bold;text-align:center;">
			Sender:
		</td>
		<td style="width:350px;font-weight:bold;font-weight:bold;text-align:center;">
			Recipient
		</td>	
	</tr>
	<tr>
		<td style="width:350px;font-weight:bold;font-weight:bold;text-align:center;font-size:28px">
			{{$contract->sender_signature}}
		</td>
		<td style="width:350px;font-weight:bold;font-weight:bold;text-align:center;font-size:28px">
			{{$contract->receiver_signature}}
		</td>	
	</tr>
</table>  